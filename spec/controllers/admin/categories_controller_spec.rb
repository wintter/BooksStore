require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :controller do
	
	before do
		allow_message_expectations_on_nil
		allow(controller).to receive(:check_login_user).and_return true
		allow(controller).to receive(:check_admin).and_return true
	end

	shared_examples "#create, #update with valid arguments" do
		describe 'redirect' do

			before { request }

			it 'to :index' do
				expect(response).to redirect_to(:admin_categories)
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
			expect(Category).to receive(:all)
			get :index
		end

	end

	describe 'GET #new' do

		it 'use #new' do
			expect(Category).to receive(:new)
			get :new
		end

	end

	describe 'GET #edit' do

		let(:category) { FactoryGirl.create(:category) }

		before do
			allow(Category).to receive(:find).and_return category
		end

		it 'use #find' do
			expect(Category).to receive(:find)
			get :edit, id: 1
		end

	end

	describe 'POST #create' do

		context 'with valid attributes' do
			let(:category_params) { FactoryGirl.attributes_for(:category) }

			before do
				allow(assigns(:category)).to receive(:save).and_return true
				allow(assigns(:category)).to receive(:title).and_return ''
			end

			it 'receives new with params' do
				expect(Category).to receive(:new).with(category_params)
				post :create, category: category_params
			end

			it_behaves_like "#create, #update with valid arguments" do
				let(:request) { post :create, category: category_params }
			end

			it_behaves_like "#create, #update with invalid arguments" do
				let(:request) { post :create, category: {title: ''} }
				let(:templates) { :new }
			end

		end

	end

	describe 'PATCH #update' do
		let(:category_params) { FactoryGirl.attributes_for(:category) }
		let(:category) { FactoryGirl.create(:category) }

		before do
			@params = {:id => '1', :category => category_params}
			allow(Category).to receive(:find).and_return category
			post :update, @params
		end

		it 'call #find' do
			expect(Category).to receive(:find).with("1")
			patch :update, @params
		end

		it_behaves_like "#create, #update with valid arguments" do
			let(:request) { patch :update, @params }
		end

		it_behaves_like "#create, #update with invalid arguments" do
			let(:request) { patch :update, id: 3, category: {title: ''} }
			let(:templates) { :edit }
		end

	end

	describe 'DELETE #destroy' do
		let(:category) { FactoryGirl.create(:category) }

		before do
			allow(Category).to receive(:find).and_return category
		end

		it 'call #destroy' do
			expect(Category).to receive_message_chain(:find, :destroy)
			delete :destroy, id: 1
		end

		it 'redirect to :index' do
			delete :destroy, id: 1
			expect(response).to redirect_to(:admin_categories)
		end

	end
	
end
