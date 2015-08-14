require 'rails_helper'

RSpec.describe BooksController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:ability) { Ability.new(user) }

  before do
    allow(controller).to receive(:current_ability).and_return(ability)
    ability.can :manage, :all
    sign_in user
  end
  
  let(:book) { FactoryGirl.create(:book) }

  shared_examples 'success flash and redirect' do
    before { req }

    it 'success flash' do
      expect(flash[:success]).to be_present
    end

    it 'redirect to HTTP_REFERER' do
      expect(response).to redirect_to(:root)
    end

  end

  describe 'GET #index' do

    it 'use before_filter find_book' do
      expect(controller).to receive(:find_book)
      get :index
    end

    it '#paginate if no params' do
      expect(Book).to receive(:paginate)
      get :index
    end

    it 'call #search if search params' do
      expect(Book).to receive_message_chain(:search, :paginate)
      get :index, search: book.title, type: '1'
    end

    it 'call #where if category params' do
      expect(Book).to receive(:where).with(category: '1')
      get :index, category_id: '1'
    end

  end

  describe 'GET #show' do
    before { get :show, id: book.id }

    it 'load @book' do
      expect(assigns(:book)).not_to be_nil
    end

    it 'load @rating' do
      expect(assigns(:rating)).not_to be_nil
    end

    it '#reviews' do
      expect(assigns(:book)).to receive(:reviews)
      get :show, id: book.id
    end

    it '#number with user' do
      expect(assigns(:book)).to receive(:number).with(user)
      get :show, id: book.id
    end

  end

  context 'add book to cart and wish list' do

    before { request.env['HTTP_REFERER'] = root_path }

    describe 'GET #add_to_cart' do

      it 'add book to cart' do
        expect { get :add_to_cart, id: book }.to change { OrderItem.count }.from(0).to(1)
      end

      it_behaves_like 'success flash and redirect' do
        let(:req) { get :add_to_cart, id: book }
      end

      it '#calculate_price' do
        expect(controller).to receive(:calculate_price)
        get :add_to_cart, id: book
      end

    end

    describe 'GET #add_to_wish_list' do

      it 'add book to wish list' do
        expect { get :add_to_wish_list, id: book }.to change { WishList.count }.from(0).to(1)
      end

      it_behaves_like 'success flash and redirect' do
        let(:req) { get :add_to_wish_list, id: book }
      end

    end

  end


end
