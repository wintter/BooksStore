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
        ability.cannot :read, Order
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
    #let(:order) { FactoryGirl.create(:order) }
     #it { p order }
=begin
      before do
        patch :update, id: order.id, order: { order_state_id: 1 }
      end

      it 'and success flash' do
        expect(flash[:success]).to be_present
      end

      it 'to :index' do
        expect(response).to redirect_to(:admin_categories)
      end
=end

    end

end
