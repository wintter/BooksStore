require 'rails_helper'

RSpec.describe Admin::BooksController, type: :controller do

	before do
		allow_message_expectations_on_nil
		allow(controller).to receive(:check_login_user).and_return true
		allow(controller).to receive(:check_admin).and_return true
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

		it 'use #all' do
			expect(Book).to receive(:all)
			get :index
		end

	end

	describe 'GET #new' do

		it 'use #new' do
			expect(Book).to receive(:new)
			get :new
		end

		it 'use #all category' do
			expect(Category).to receive(:all)
			get :new
		end

		it 'use #all author' do
			expect(Author).to receive(:all)
			get :new
		end

	end

	describe 'GET #edit' do

		let(:book) { FactoryGirl.create(:book) }

		before do
			allow(Book).to receive(:find).and_return book
		end

		it 'use #find' do
			expect(Book).to receive(:find)
			get :edit, id: 1
		end

		it 'use #all category' do
			expect(Category).to receive(:all)
			get :new
		end

		it 'use #all author' do
			expect(Author).to receive(:all)
			get :new
		end

	end

	describe 'POST #create' do

		context 'with valid attributes' do
			let(:book_params) { FactoryGirl.attributes_for(:book) }

			before do
				allow(assigns(:book)).to receive(:save).and_return true
				allow(assigns(:book)).to receive(:title).and_return ''
			end

			it 'receives new with params' do
				expect(Book).to receive(:new).with(book_params)
				post :create, book: book_params
			end

			it_behaves_like "#create, #update with valid arguments" do
				let(:request) { post :create, book: book_params }
			end

			it_behaves_like "#create, #update with invalid arguments" do
				let(:request) { post :create, book: {title: ''} }
				let(:templates) { :new }
			end

		end

	end

	describe 'PATCH #update' do
		let(:book_params) { FactoryGirl.attributes_for(:book) }
		let(:book) { FactoryGirl.create(:book) }

		before do
			@params = {:id => '1', :book => book_params}
			allow(Book).to receive(:find).and_return book
			post :update, @params
		end

		it 'call #find' do
			expect(Book).to receive(:find).with("1")
			patch :update, @params
		end

		it_behaves_like "#create, #update with valid arguments" do
			let(:request) { patch :update, @params }
		end

		it_behaves_like "#create, #update with invalid arguments" do
			let(:request) { patch :update, id: 3, book: {title: ''} }
			let(:templates) { :edit }
		end

	end

	describe 'DELETE #destroy' do
		let(:book) { FactoryGirl.create(:book) }

		before do
			allow(Book).to receive(:find).and_return book
		end

		it 'call #destroy' do
			expect(Book).to receive_message_chain(:find, :destroy)
			delete :destroy, id: 1
		end

		it 'redirect to :index' do
			delete :destroy, id: 1
			expect(response).to redirect_to(:admin_books)
		end

	end


end
