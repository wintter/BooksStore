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

    context 'first_step' do
      before { get :show, id: :order_address }

      it 'render order_address template' do
        expect(response).to render_template('order_address')
      end

      it 'create @billing_address' do
        expect(assigns(:billing_address)).to be_instance_of Address
      end

      it 'create @shipping_address' do
        expect(assigns(:shipping_address)).to be_instance_of Address
      end

    end

    context 'second_step' do
      before { get :show, id: :order_delivery }

      it 'render order_delivery template' do
        expect(response).to render_template('order_delivery')
      end

      it 'create @delivery' do
        expect(assigns(:delivery)).to eq Delivery.all
      end

    end

    context 'third_step' do
      before { get :show, id: :order_payment }

      it 'render order_payment template' do
        expect(response).to render_template('order_payment')
      end

      it 'create @credit_card' do
        expect(assigns(:credit_card)).to be_instance_of CreditCard
      end
    end

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

    context 'first_step' do
      let(:billing_address) { FactoryGirl.attributes_for(:address) }
      let(:shipping_address) { FactoryGirl.attributes_for(:address) }
      let(:invalid_address) { FactoryGirl.attributes_for(:address, street_address: '') }

      it 'call #create_address' do
        expect(controller).to receive(:create_addresses).with(billing_address, shipping_address)
        patch :update, id: :order_address, billing_address: billing_address, shipping_address: shipping_address
      end

      describe 'valid form' do
        before { patch :update, id: :order_address, billing_address: billing_address, shipping_address: shipping_address }

        it 'redirect to next step' do
          expect(response).to redirect_to(action: 'show', id: :order_delivery)
        end

      end

      describe 'invalid form' do
        before { patch :update, id: :order_address, billing_address: billing_address, shipping_address: invalid_address }

        it 'not redirect if errors' do
          expect(response).to render_template(:order_address)
        end

        it 'address entity has errors' do
          expect(assigns(:shipping_address).errors).not_to be_nil
        end
      end

    end

    context 'second step' do

      describe 'valid form' do
        before { patch :update, id: :order_delivery, delivery: FactoryGirl.create(:delivery) }

        it 'call #order_delivery_params' do
          expect(controller).to receive(:create_delivery)
          patch :update, id: :order_delivery, delivery: FactoryGirl.create(:delivery)
        end

        it 'redirect to next step' do
          expect(response).to redirect_to(action: :show, id: :order_payment)
        end

      end

      describe 'invalid form' do
        before { patch :update, id: :order_delivery, delivery: nil }

        it 'not redirect if errors' do
          expect(response).to render_template(:order_delivery)
        end

      end

    end

    context 'third step' do
      let(:credit_card) { FactoryGirl.attributes_for(:credit_card) }
      let(:invalid_credit_card) { FactoryGirl.attributes_for(:credit_card, CVV: '') }

      it 'call #check_valid_request' do
        expect(controller).to receive(:create_credit_card).with(credit_card)
        patch :update, id: :order_payment, credit_card: credit_card
      end

      describe 'valid form' do
        before { patch :update, id: :order_payment, credit_card: credit_card }

        it 'redirect to next step' do
          expect(response).to redirect_to(action: :show, id: :order_confirm)
        end

      end

      describe 'invalid form' do
        before { patch :update, id: :order_payment, credit_card: invalid_credit_card }

        it 'not redirect if errors' do
          expect(response).to render_template(:order_payment)
        end

        it 'address entity has errors' do
          expect(assigns(:credit_card).errors).not_to be_nil
        end
      end

    end

    context 'firth step' do
      before do
        cart.update(billing_address: FactoryGirl.create(:address), shipping_address: FactoryGirl.create(:address),
                    delivery: FactoryGirl.create(:delivery), credit_card: FactoryGirl.create(:credit_card))
      end
      after { patch :update, id: :order_confirm }

      it '#create' do
        expect(controller).to receive(:create)
      end

    end

  end
end
