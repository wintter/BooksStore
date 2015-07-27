require 'rails_helper'

RSpec.describe WishListsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:ability) { Ability.new(user) }
  let(:book) { FactoryGirl.create(:book) }

  before do
    allow(controller).to receive(:current_ability).and_return(ability)
    ability.can :manage, :all
    sign_in user
  end

  let(:wish_list) { FactoryGirl.create(:wish_list) }

  describe 'GET #index' do

    it 'generate @wish_lists' do
      expect(assigns(@wish_lists)).not_to be_nil
      get :index
    end

  end

  describe 'DELETE #destroy' do

    it 'redirect to index' do
      user.wish_lists.push wish_list
      delete :destroy, id: wish_list
      expect(response).to redirect_to(wish_lists_path)
    end

  end

end
