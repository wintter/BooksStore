require 'rails_helper'

RSpec.describe AuthsController, type: :controller do

  before do
    request.env['devise.mapping'] = Devise.mappings[:user]
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
    get :facebook
  end

  it 'redirect to root' do
    expect(response).to redirect_to(:root)
  end

  it 'success flash' do
    expect(flash[:notice]).not_to be_nil
  end


end
