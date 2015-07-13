require 'rails_helper'

RSpec.describe Admin::AuthorsController, type: :controller do

  before do
	  allow_message_expectations_on_nil
    allow(controller).to receive(:check_login_user).and_return true
    allow(controller).to receive(:check_admin).and_return true
  end

  shared_examples "#create, #update with valid arguments" do
	  describe 'redirect' do

		  before { request }

		  it 'to :index' do
			  expect(response).to redirect_to(:admin_authors)
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
      expect(Author).to receive(:all)
      get :index
    end

  end

  describe 'GET #new' do

    it 'use #new' do
      expect(Author).to receive(:new)
      get :new
    end

  end

  describe 'GET #edit' do

    let(:author) { FactoryGirl.create(:author) }

    before do
      allow(Author).to receive(:find).and_return author
    end

    it 'use #find' do
      expect(Author).to receive(:find)
      get :edit, id: 1
    end

    it 'correct find' do
      get :edit, id: 1
      expect(assigns(:author)).to eq author
    end

  end

  describe 'POST #create' do

	  context 'with valid attributes' do
		  let(:author_params) { FactoryGirl.attributes_for(:author) }

		   before do
			  allow(assigns(:author)).to receive(:save).and_return true
			  allow(assigns(:author)).to receive(:firstname).and_return ''
		  end

		  it 'receives new with params' do
			  expect(Author).to receive(:new).with(author_params)
			  post :create, author: author_params
		  end

		  it_behaves_like "#create, #update with valid arguments" do
			  let(:request) { post :create, author: author_params }
		  end

		  it_behaves_like "#create, #update with invalid arguments" do
			  let(:request) { post :create, author: {firstname: 'Bob'} }
			  let(:templates) { :new }
		  end

	  end

  end

  describe 'PATCH #update' do
	  let(:author_params) { FactoryGirl.attributes_for(:author) }
	  let(:author) { FactoryGirl.create(:author) }

	  before do
		  @params = {:id => '1', :author => author_params}
		  allow(Author).to receive(:find).and_return author
		  post :update, @params
	  end

	  it 'call #find' do
			expect(Author).to receive(:find).with("1")
		  patch :update, @params
	  end

	  it_behaves_like "#create, #update with valid arguments" do
		  let(:request) { patch :update, @params }
	  end

	  it_behaves_like "#create, #update with invalid arguments" do
		  let(:request) { patch :update, id: 3, author: {firstname: ''} }
		  let(:templates) { :edit }
	  end

  end

	describe 'DELETE #destroy' do
		let(:author) { FactoryGirl.create(:author) }

		before do
			allow(Author).to receive(:find).and_return author
		end

		it 'call #destroy' do
			expect(Author).to receive_message_chain(:find, :destroy)
			delete :destroy, id: 1
		end

		it 'redirect to :index' do
			delete :destroy, id: 1
			expect(response).to redirect_to(:admin_authors)
		end

	end

end
