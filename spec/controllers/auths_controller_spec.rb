require 'rails_helper'

RSpec.describe AuthsController, type: :controller do

  describe 'GET #new' do

    it 'renders :new template' do
      get :new
      expect(response).to render_template :new
    end

  end

  describe 'POST #create' do
    let(:user) { FactoryGirl.create(:user) }

    context 'with existing user' do

      before do
        allow(User).to receive(:find_by).and_return user
        post :create, password: user.password, email: user.email
      end

      it 'redirects to user path' do
        expect(response).to redirect_to(user_path user)
      end

      it 'show success flash message' do
        expect(flash[:success]).to eq 'Hello ' << user.name
      end
    end

    context 'with invalid user' do

      before do
        allow(User).to receive(:find_by).and_return nil
        post :create, password: user.password, email: user.email
      end

      it 'render new template' do
        expect(response).to render_template :new
      end

      it 'show errors flash message' do
        expect(flash[:errors]).to eq 'User not found'
      end
    end

    context 'call methods #login and #authenticate with existing user' do

      before do
        allow(User).to receive(:find_by).and_return user
        allow(user).to receive(:authenticate).and_return true
        allow(controller).to receive(:login).and_return true
      end

      after { post :create, password: user.password, email: user.email }

      it '#authenticate' do
        expect(user).to receive(:authenticate)
      end

      it '#login' do
        expect(controller).to receive(:login)
      end

      it '#login with user' do
        expect(controller).to receive(:login).with(user)
      end

    end

  end

  describe 'DELETE #destroy' do

    before do
      delete :destroy, id: '1'
    end

    it 'call #logout' do
      expect(controller).to receive(:logout).and_return true
      delete :destroy, id: '1'
    end

    it 'redirects to root path' do
      expect(response).to redirect_to(root_path)
    end

  end

end
