require 'rails_helper'

RSpec.describe OrdersController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:ability) { Ability.new(user) }

  before do
    allow(controller).to receive(:current_ability).and_return(ability)
    ability.can :manage, :all
    sign_in user
  end

  let!(:cart) { user.cart }

  describe 'GET #index' do

    before { get :index }

    it 'create @orders' do
      expect(assigns(:orders)).not_to be_nil
    end

    it '#not_in_progress' do
      expect(assigns(:orders)).to receive(:valid_orders)
      get :index
    end

  end



  describe 'POST #create' do
    before do
      cart.update(billing_address: FactoryGirl.create(:address), shipping_address: FactoryGirl.create(:address),
                  delivery: FactoryGirl.create(:delivery), credit_card: FactoryGirl.create(:credit_card))
      post :create
    end

    it 'redirect to root' do
      expect(response).to redirect_to(:root)
    end

    it 'success flash' do
      expect(flash[:success]).not_to be_nil
    end

    it 'remove \'in progress\'' do
      expect(cart.reload.state).not_to eq 'in_progress'
    end

    it 'changes in progress to second state' do
      expect(cart.reload.state).to eq 'in_queue'
    end

  end



  describe 'GET #coupon' do
    let!(:coupon) { FactoryGirl.create(:coupon, number: 1111, discount: 100) }

    before do
      request.env['HTTP_REFERER'] = root_path
      allow(controller).to receive(:calculate_price)
      get :coupon, coupon: 1111
    end

    it '.calculate_price' do
      expect(controller).to receive(:calculate_price)
      get :coupon, coupon: 1111
    end

    context 'coupon exist' do

      it 'find coupon' do
        expect(Coupon).to receive(:find_by).with(number: '1111')
        get :coupon, coupon: 1111
      end

      it 'update cart' do
        expect(cart.reload.coupon).to eq coupon
      end

      it 'success flash' do
        expect(flash[:success]).not_to be_nil
      end

      it 'redirect_to http_referer' do
        expect(response).to redirect_to(:root)
      end

    end

    context 'coupon does not exist' do
      let!(:coupon) { FactoryGirl.create(:coupon, number: 1112, discount: 100) }

      it 'error flash' do
        expect(flash[:error]).not_to be_nil
      end

      it 'redirect_to http_referer' do
        expect(response).to redirect_to(:root)
      end
    end

    context 'user already use coupon' do
      before do
        cart.update(coupon: coupon)
        get :coupon, coupon: 1111
      end

      it 'flash error' do
        expect(flash[:error]).not_to be_nil
      end

    end

  end

end
