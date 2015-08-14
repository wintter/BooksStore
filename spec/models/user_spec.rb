require 'rails_helper'

RSpec.describe User, type: :model do

    let(:subject) { FactoryGirl.create(:user) }

    it { expect(subject).to validate_presence_of(:name) }
    it { expect(subject).to validate_presence_of(:email) }
    it { expect(subject).to accept_nested_attributes_for(:billing_address) }
    it { expect(subject).to accept_nested_attributes_for(:shipping_address) }

    it { expect(subject).to have_many :ratings }
    it { expect(subject).to have_many :orders }

  describe '#facebook_login' do

    let(:request) { OmniAuth.config.mock_auth[:facebook] }

    it 'create new user' do
      expect(User.facebook_login(request)).to be_instance_of(User)
    end

    it 'user have email' do
      expect(User.facebook_login(request)).to respond_to(:email)
    end

    it 'user have name' do
      expect(User.facebook_login(request)).to respond_to(:name)
    end

    it 'user have password' do
      expect(User.facebook_login(request)).to respond_to(:password)
    end

  end


end
