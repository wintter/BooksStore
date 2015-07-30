require 'rails_helper'

RSpec.describe OrdersController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:ability) { Ability.new(user) }

  before do
    allow(controller).to receive(:current_ability).and_return(ability)
    ability.can :manage, :all
    sign_in user
  end

  describe 'GET #index' do

    before { get :index }

    it 'create @orders' do
      expect(assigns(@orders)).not_to be_nil
    end
  end

  describe 'GET #show' do

    context 'first_step' do
      let!(:first_step) { get :show, id: :order_address }

      it 'render order_address template' do
        expect(response).to render_template('order_address')
      end

      it 'create @address' do
        expect(assigns(:address)).to be_instance_of Address
      end
    end

    context 'second_step' do
      let!(:second_step) { get :show, id: :order_delivery }

      it 'render order_delivery template' do
        expect(response).to render_template('order_delivery')
      end
    end

    context 'third_step' do
      let!(:third_step) { get :show, id: :order_payment }

      it 'render order_payment template' do
        expect(response).to render_template('order_payment')
      end

      it 'create @credit_card' do
        expect(assigns(:credit_card)).to be_instance_of CreditCard
      end
    end

    context 'fourth_step' do
      #let!(:order_confirm) { get :show, id: :order_confirm }

      before do
        FactoryGirl.create(:cart_item, cart: user.cart)
      end

      it 'render order_confirm template' do
        #expect(response).to render_template('order_confirm')
      end

    end


  end

  describe 'POST #create' do
    before do
      FactoryGirl.create(:cart, user: user)
      FactoryGirl.create(:order_state)
      FactoryGirl.create(:cart_item, cart: user.cart, book: FactoryGirl.create(:book))
      post :create
    end

    it 'redirect to root' do
      expect(response).to redirect_to(:root)
    end

    it 'success flash' do
      expect(flash[:success]).not_to be_nil
    end
  end

  describe 'PATCH #update' do

    context 'first_step' do
      let(:address) { FactoryGirl.attributes_for(:address) }
      let(:invalid_address) { FactoryGirl.attributes_for(:address, street_address: '') }

      it 'call #check_valid_request' do
        expect(controller).to receive(:check_valid_request).with(Address, address)
        patch :update, id: :order_address, address: address
      end

      describe 'valid form' do
        before { patch :update, id: :order_address, address: address }

        it 'redirect to next step' do
          expect(response).to redirect_to(action: 'show', id: :order_delivery)
        end

        it 'set address in session' do
          expect(session['order_address']).not_to be_nil
        end
      end

      describe 'invalid form' do
        before { patch :update, id: :order_address, address: invalid_address }

        it 'not redirect if errors' do
          expect(response).to render_template(:order_address)
        end

        it 'address entity has errors' do
          expect(assigns(:address).errors).not_to be_nil
        end
      end

    end

    context 'second step' do

      describe 'valid form' do
        before { patch :update, id: :order_delivery, delivery: 5 }

        it 'set delivery to session' do
          expect(session['order_delivery']).not_to be_nil
        end

        it 'call #order_delivery_params' do
          expect(controller).to receive(:order_delivery_params)
          patch :update, id: :order_delivery, delivery: 5
        end

        it 'redirect to next step' do
          expect(response).to redirect_to(action: 'show', id: :order_payment)
        end

      end

      describe 'invalid form' do
        before { patch :update, id: :order_delivery, delivery: 1000 }

        it 'not redirect if errors' do
          expect(response).to render_template(:order_delivery)
        end

      end

    end

    context 'third step' do
      let(:credit_card) { FactoryGirl.attributes_for(:credit_card) }
      let(:invalid_credit_card) { FactoryGirl.attributes_for(:credit_card, CVV: '') }

      it 'call #check_valid_request' do
        expect(controller).to receive(:check_valid_request).with(CreditCard, credit_card)
        patch :update, id: :order_payment, credit_card: credit_card
      end

      describe 'valid form' do
        before { patch :update, id: :order_payment, credit_card: credit_card }

        it 'redirect to next step' do
          expect(response).to redirect_to(action: 'show', id: :order_confirm)
        end

        it 'set address in session' do
          expect(session['order_creditcard']).not_to be_nil
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
        FactoryGirl.create(:cart, user: user)
        FactoryGirl.create(:order_state)
        FactoryGirl.create(:cart_item, cart: user.cart, book: FactoryGirl.create(:book))
      end
      before { patch :update, id: :order_confirm }

      xit '#create' do
        expect(controller).to receive(:create)
        patch :update, id: :order_confirm
      end

    end

  end

end
