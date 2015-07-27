require 'rails_helper'

RSpec.describe CartItemsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:ability) { Ability.new(user) }

  let(:cart_item) { FactoryGirl.create(:cart_item) }

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
  end

  describe 'DELETE #destroy' do
  end



end
