require 'rails_helper'

RSpec.describe Admin::AuthorsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:ability) { Ability.new(user) }

  before do
    allow_message_expectations_on_nil
    allow(controller).to receive(:current_ability).and_return(ability)
    ability.can :manage, :all
    sign_in user
  end

  describe 'GET #index' do

    context 'cancan doesnt allow :index' do
      before do
        ability.cannot :read, Author
        get :index
      end
      it { expect(response).to redirect_to(root_path) }
    end

  end

  describe 'GET #new' do

    context 'cancan doesnt allow :index' do
      before do
        ability.cannot :create, Author
        get :new
      end
      it { expect(response).to redirect_to(root_path) }
    end

  end

  describe 'GET #edit' do

    context 'cancan doesnt allow :index' do
      let(:author) { FactoryGirl.create(:author) }
      before do
        ability.cannot :update, Author
        get :edit, id: author.id
      end
      it { expect(response).to redirect_to(root_path) }
    end

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

  describe 'POST #create' do
    let(:author_params) { FactoryGirl.attributes_for(:author) }

    context 'with valid attributes' do

      before do
        allow(assigns(:author)).to receive(:save).and_return true
        allow(assigns(:author)).to receive(:firstname).and_return ''
      end

      it_behaves_like "#create, #update with valid arguments" do
        let(:request) { post :create, author: author_params }
      end

      it_behaves_like "#create, #update with invalid arguments" do
        let(:request) { post :create, author: {firstname: 'Bob'} }
        let(:templates) { :new }
      end

    end

    context 'cancan doesnt allow :create' do
      before do
        ability.cannot :create, Author
        post :create, author: author_params
      end
      it { expect(response).to redirect_to(root_path) }
    end

  end

  describe 'PATCH #update' do
    let(:author_params) { FactoryGirl.attributes_for(:author) }
    let(:author) { FactoryGirl.create(:author) }

    before do
      @params = {id: author.id, author: author_params}
    end

    it_behaves_like "#create, #update with valid arguments" do
      let(:request) { patch :update, @params }
    end

    it_behaves_like "#create, #update with invalid arguments" do
      let(:request) { patch :update, id: author.id, author: {firstname: ''} }
      let(:templates) { :edit }
    end

    context 'cancan doesnt allow :create' do
      before do
        ability.cannot :update, Author
        patch :update, author_params.merge(id: author.id)
      end
      it { expect(response).to redirect_to(root_path) }
    end

  end

  describe 'DELETE #destroy' do
    let(:author) { FactoryGirl.create(:author) }

    before do
      delete :destroy, id: author.id
    end

    it 'redirect to :index' do
      expect(response).to redirect_to(:admin_authors)
    end

    context 'cancan doesnt allow :create' do
      before do
        ability.cannot :destroy, Author
      end
      it { expect(response).to redirect_to(:admin_authors) }
    end

  end

end
