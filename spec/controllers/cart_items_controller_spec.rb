require 'rails_helper'

RSpec.describe CartItemsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:ability) { Ability.new(user) }

  before do
    allow(controller).to receive(:current_ability).and_return(ability)
    ability.can :manage, :all
    sign_in user
  end

  let(:cart_item) { FactoryGirl.create(:cart_item, cart: user.cart) }

  describe 'GET #index' do

    before do
      get :index
      user.reload
    end

    it '#initialize_cart' do
      expect(controller).to receive(:initialize_cart)
      get :index
    end

    it 'create cart' do
      expect(user.cart).not_to be_nil
    end

    it 'have cart item' do
      expect(user.cart.cart_items).not_to be_nil
    end

  end

  describe 'PATCH #update' do
    before do
      request.env['HTTP_REFERER'] = 'page'
      patch :update, id: cart_item
    end

    it '#initialize_cart' do
      expect(controller).to receive(:initialize_cart)
      patch :update, id: cart_item
    end

    it '#increment quantity' do
      expect(assigns(:cart_item)).to receive(:increment!).with(:quantity)
      patch :update, id: cart_item
    end

    it '#increment! cart_item' do
      cart_item
      expect(cart_item.reload.quantity).to eq 2
    end

    it 'redirect_to HTTP_REFERER' do
      expect(response).to redirect_to('page')
    end

  end

  describe 'DELETE #destroy' do

    context 'with quantity > 1' do

      before do
        cart_item.update(quantity: 5)
        delete :destroy, id: cart_item, reduce: true
      end

      it '#decrement if quantity > 1' do
        expect(cart_item.reload.quantity).to eq 4
      end

      it '#decrement quantity' do
        expect(assigns(:cart_item)).to receive(:decrement!).with(:quantity)
        delete :destroy, id: cart_item, reduce: true
      end

    end

    context 'with quantity = 1' do

      before { delete :destroy, id: cart_item }

      it '#destroy' do
        expect(CartItem.count).to eq 0
      end

    end

    it 'redirect to index' do
      delete :destroy, id: cart_item
      expect(response).to redirect_to(action: :index)
    end

    it '#initialize_cart' do
      expect(controller).to receive(:initialize_cart)
      delete :destroy, id: cart_item
    end

  end

end
