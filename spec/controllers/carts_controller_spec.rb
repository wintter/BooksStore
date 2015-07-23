require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:ability) { Ability.new(user) }

  let(:cart_item) { FactoryGirl.create(:cart_item) }
  let(:book) { FactoryGirl.create(:book) }
  let(:get_items) { user.cart.cart_items }

  before do
    allow(controller).to receive(:current_ability).and_return(ability)
    ability.can :manage, :all
    sign_in user
  end

  describe 'GET #index' do

    it 'run create callback' do
      get :index
      expect(assigns(@cart)).not_to be_nil
    end

    it 'create cart' do
      get :index
      expect(user.cart).not_to be_nil
    end

  end

  describe 'PATCH #update' do

    before do
      request.env['HTTP_REFERER'] = root_path
    end

    context 'add existing book' do

      before do
        patch :update, id: book.id
      end

      it '#increment' do
        patch :update, id: book.id
        expect(get_items.where(book: book).first.quantity).to eq 2
      end

    end

    context 'add new items' do

      before do
        patch :update, id: book.id
      end

      it 'have items' do
        expect(get_items).not_to eq nil
      end

      it 'items quantity eq 1' do
        expect(get_items.where(book: book).first.quantity).to eq 1
      end

    end

    it 'generate flash success' do
      patch :update, id: book.id
      expect(flash[:success]).to be_present
    end

    it 'redirect to HTTP_REFERER' do
      patch :update, id: book.id
      expect(response).to redirect_to(:root)
    end

  end

  describe 'DELETE #destroy' do

    before do
      cart_item
      delete :destroy, id: book.id
    end

    context 'without params to #decrement' do


      it 'redirect to action :index' do
        expect(response).to redirect_to(:carts)
      end

      it 'destroy cart' do
        expect(get_items.count).to eq 0
      end

    end

  end

  context 'with params to #decrement' do

    before do
      cart_item.quantity = 2
      allow(CartItem).to receive(:find).and_return cart_item
    end

    it 'receive #decrement' do
      expect(cart_item).to receive(:decrement!)
      delete :destroy, id: cart_item.id, reduce: true
    end

    it 'decrement by 1' do
      delete :destroy, id: cart_item.id, reduce: true
      expect(cart_item.quantity).to eq 1
    end

  end

end
