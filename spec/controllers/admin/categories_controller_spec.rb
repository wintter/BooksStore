require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :controller do

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
        ability.cannot :index, Admin::CategoriesController
        get :index
      end
      it { expect(response).to redirect_to(root_path) }
    end

  end

  describe 'GET #new' do

    context 'cancan doesnt allow :new' do
      before do
        ability.cannot :new, Admin::CategoriesController
        get :new
      end
      it { expect(response).to redirect_to(root_path) }
    end

  end

  describe 'GET #edit' do

    context 'cancan doesnt allow :edit' do
      let(:category) { FactoryGirl.create(:category) }
      before do
        ability.cannot :edit, Admin::CategoriesController
        get :edit, id: category.id
      end
      it { expect(response).to redirect_to(root_path) }
    end

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

  describe 'POST #create' do
    let(:category_params) { FactoryGirl.attributes_for(:category) }

    context 'with valid attributes' do

      before do
        allow(assigns(:category)).to receive(:save).and_return true
        allow(assigns(:category)).to receive(:firstname).and_return ''
      end

      it_behaves_like "#create, #update with valid arguments" do
        let(:request) { post :create, category: category_params }
      end

      it_behaves_like "#create, #update with invalid arguments" do
        let(:request) { post :create, category: {title: ''} }
        let(:templates) { :new }
      end

    end

    context 'cancan doesnt allow :create' do
      before do
        ability.cannot :create, Admin::CategoriesController
        post :create, category: category_params
      end
      it { expect(response).to redirect_to(root_path) }
    end

  end

  describe 'PATCH #update' do
    let(:category_params) { FactoryGirl.attributes_for(:category) }
    let(:category) { FactoryGirl.create(:category) }

    before do
      @params = {id: category.id, category: category_params}
    end

    it_behaves_like "#create, #update with valid arguments" do
      let(:request) { patch :update, @params }
    end

    it_behaves_like "#create, #update with invalid arguments" do
      let(:request) { patch :update, id: category.id, category: {title: ''} }
      let(:templates) { :edit }
    end

    context 'cancan doesnt allow :update' do
      before do
        ability.cannot :update, Admin::CategoriesController
        patch :update, category_params.merge(id: category.id)
      end
      it { expect(response).to redirect_to(root_path) }
    end

  end

  describe 'DELETE #destroy' do
    let(:category) { FactoryGirl.create(:category) }

    before do
      delete :destroy, id: category.id
    end

    it 'redirect to :index' do
      expect(response).to redirect_to(:admin_categories)
    end

    context 'cancan doesnt allow :destroy' do
      before do
        ability.cannot :destroy, Admin::CategoriesController
      end
      it { expect(response).to redirect_to(:admin_categories) }
    end

  end

end
