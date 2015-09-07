require 'rails_helper'

RSpec.describe OrderStepsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:ability) { Ability.new(user) }

  before do
    allow(controller).to receive(:current_ability).and_return(ability)
    ability.can :manage, :all
    sign_in user
  end

  let!(:cart) { user.cart }

  describe 'GET #show' do

    context 'fourth_step' do

      it 'redirect to address if address does not exist' do
        get :show, id: :order_confirm
        expect(response).to redirect_to(action: :show, id: :order_address)
      end

      it 'redirect_to delivery if delivery does not exist' do
        cart.update(billing_address: FactoryGirl.create(:address), shipping_address: FactoryGirl.create(:address))
        get :show, id: :order_confirm
        expect(response).to redirect_to(action: :show, id: :order_delivery)
      end

      it 'redirect_to credit_card if credit_card does not exist' do
        cart.update(billing_address: FactoryGirl.create(:address), shipping_address: FactoryGirl.create(:address),
                    delivery: FactoryGirl.create(:delivery))
        get :show, id: :order_confirm
        expect(response).to redirect_to(action: :show, id: :order_payment)
      end

      it 'render confirm template' do
        cart.update(billing_address: FactoryGirl.create(:address), shipping_address: FactoryGirl.create(:address),
                    delivery: FactoryGirl.create(:delivery), credit_card: FactoryGirl.create(:credit_card))
        get :show, id: :order_confirm
        expect(response).to render_template('order_confirm')
      end

    end

  end


  describe 'PATCH #update' do

    before do
      @params = { id: :order_address, billing_address: FactoryGirl.attributes_for(:address),
                  shipping_address: FactoryGirl.attributes_for(:address) }
      patch :update, id: :order_address
    end

    it 'build order' do
      expect(assigns(:form)).not_to be_nil
    end

    it 'update order with step and params' do
      expect(assigns(:form)).to receive(:update)
      patch :update, @params
    end

    it 'next step if order save' do
      expect(response).to redirect_to(action: :show, id: :order_delivery)
    end

    it 'render current step if order not save' do
      @params[:billing_address][:street_address] = nil
      patch :update, @params
      expect(response).to render_template('order_address')
    end

  end
end
