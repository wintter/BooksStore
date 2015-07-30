require 'rails_helper'

RSpec.describe Admin::BooksController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:ability) { Ability.new(user) }

  before do
    allow_message_expectations_on_nil
    allow(controller).to receive(:current_ability).and_return(ability)
    ability.can :manage, :all
    sign_in user
  end

	shared_examples "#create, #update with valid arguments" do
		describe 'redirect' do

			before { request }

			it 'to :index' do
				expect(response).to redirect_to(:admin_books)
			end

			it 'and success flash' do
				expect(flash[:success]).to be_present
			end

		end
	end

	shared_examples "#create, #update with invalid arguments" do
		describe 'render' do

			before { request }

			it 'templates' do
				expect(response).to render_template(templates)
			end

		end
	end

  describe 'GET #index' do

    context 'cancan doesnt allow :index' do
      before do
        ability.cannot :index, Admin::BooksController
        get :index
      end
      it { expect(response).to redirect_to(root_path) }
    end

  end

	describe 'GET #new' do

    context 'cancan doesnt allow :new' do
      before do
        ability.cannot :new, Admin::BooksController
        get :new
      end
      it { expect(response).to redirect_to(root_path) }
    end

	end

	describe 'GET #edit' do

		let(:book) { FactoryGirl.create(:book) }

		before do
			allow(Book).to receive(:find).and_return book
		end

    context 'cancan doesnt allow :edit' do
      let(:book) { FactoryGirl.create(:book) }
      before do
        ability.cannot :edit, Admin::BooksController
        get :edit, id: book.id
      end
      it { expect(response).to redirect_to(root_path) }
    end

	end

	describe 'POST #create' do
    let(:book_params) { FactoryGirl.attributes_for(:book) }

    context 'with valid attributes' do

			before do
				allow(assigns(:book)).to receive(:save).and_return true
				allow(assigns(:book)).to receive(:title).and_return ''
			end

			it_behaves_like "#create, #update with valid arguments" do
				let(:request) { post :create, book: book_params }
			end

			it_behaves_like "#create, #update with invalid arguments" do
				let(:request) { post :create, book: {title: ''} }
				let(:templates) { :new }
			end

    end

    context 'cancan doesnt allow :create' do
      before do
        ability.cannot :create, Admin::BooksController
        post :create, book: book_params
      end
      it { expect(response).to redirect_to(root_path) }
    end

	end

	describe 'PATCH #update' do
		let(:book_params) { FactoryGirl.attributes_for(:book) }
		let(:book) { FactoryGirl.create(:book) }

		before do
      @params = { id: book.id, book: book_params }
    end

		it_behaves_like "#create, #update with valid arguments" do
			let(:request) { patch :update, @params }
		end

		it_behaves_like "#create, #update with invalid arguments" do
			let(:request) { patch :update, id: book.id, book: {title: ''} }
			let(:templates) { :edit }
    end

    context 'cancan doesnt allow :update' do
      before do
        ability.cannot :update, Admin::BooksController
        patch :update, book_params.merge(id: book.id)
      end
      it { expect(response).to redirect_to(root_path) }
    end

	end

	describe 'DELETE #destroy' do
		let(:book) { FactoryGirl.create(:book) }

		before do
      delete :destroy, id: book.id
    end

    context 'cancan doesnt allow :destroy' do
      before do
        ability.cannot :destroy, Admin::BooksController
      end
      it { expect(response).to redirect_to(:admin_books) }
    end

		it 'redirect to :index' do
			expect(response).to redirect_to(:admin_books)
		end

	end


end
