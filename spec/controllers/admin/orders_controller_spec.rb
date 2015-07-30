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

    it 'use OrderState' do
      expect(OrderState).to receive(:all)
      get :index
    end

  end

  describe 'PATCH #update' do
    let(:order_state) { FactoryGirl.create(:order_state) }
    let(:order) { FactoryGirl.create(:order) }
    before do
      patch :update, id: order.id, order: { order_state_id: order_state }
    end

    it 'redirect to index' do
      expect(response).to redirect_to(action: :index)
    end

    it 'success flash' do
      expect(flash[:success]).not_to be_nil
    end

  end

end
