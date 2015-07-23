require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:ability) { Ability.new(user) }
  let(:book) { FactoryGirl.create(:book)}

  before do
    allow(controller).to receive(:current_ability).and_return(ability)
    ability.can :manage, :all
    sign_in user
  end


  describe 'GET #index' do

    it '#paginate if no params' do
      expect(Book).to receive(:paginate)
      get :index
    end

    it 'call #search if params[:text]' do
      expect(Book).to receive(:search)
      get :index, text: Faker::Commerce.product_name
    end

  end

  describe 'GET #show' do

    it '#get_rate' do
      expect(Rating).to receive(:get_rate)
      get :show, id: book.id
    end

    it '#get_review' do
      expect(Rating).to receive(:get_review)
      get :show, id: book.id
    end

  end



end
