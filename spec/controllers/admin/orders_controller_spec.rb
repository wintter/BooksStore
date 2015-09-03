require 'rails_helper'

RSpec.describe Admin::OrdersController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:ability) { Ability.new(user) }

  before do
    allow_message_expectations_on_nil
    allow(controller).to receive(:current_ability).and_return(ability)
    ability.can :manage, :all
    sign_in user
  end

  describe 'GET #index' do

    context 'cancan doesnt allow :index' do
      before do
        ability.cannot :index, Admin::OrdersController
        get :index
      end
      it { expect(response).to redirect_to(root_path) }
    end

  end

  describe 'PATCH #update' do
    let(:order) { FactoryGirl.create(:order, state: 'in_queue') }
    before do
      patch :update, id: order.id, order: order
    end

    it 'redirect to index' do
      expect(response).to redirect_to(action: :index)
    end

    it 'success flash' do
      expect(flash[:success]).not_to be_nil
    end

    it 'state to in_delivery' do
      expect(order.reload.state).to eq 'in_delivery'
    end

    it 'state to delivered' do
      allow(OrderMailer).to receive_message_chain(:order_delivered, :deliver_now)
      order.update(state: 'in_delivery')
      patch :update, id: order.id, order: order
      expect(order.reload.state).to eq 'delivered'
    end

    it 'cancel if params[:cancel]' do
      patch :update, id: order.id, order: order, cancel: true
      expect(order.reload.state).to eq 'canceled'
    end

  end

end
