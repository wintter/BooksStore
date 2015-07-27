require 'rails_helper'

RSpec.describe RatingsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:ability) { Ability.new(user) }
  let(:book) { FactoryGirl.create(:book) }

  before do
    allow(controller).to receive(:current_ability).and_return(ability)
    ability.can :manage, :all
    sign_in user
  end

  describe 'POST #create' do

    after { post :create, book_id: book.id, user_id: user.id }

    it 'use before_filter method #find_or_initialize_rating' do
      expect(controller).to receive(:find_or_initialize_rating)
    end

    it 'call #find_or_initialize_rating' do
      expect(Rating).to receive(:find_or_initialize_by)
    end

    it 'create @rating' do
      expect(assigns(@rating)).not_to be_nil
    end

    it 'success flash' do
      post :create, book_id: book.id, user_id: user.id
      expect(flash[:success]).not_to be_nil
    end


  end

end
