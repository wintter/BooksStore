require 'rails_helper'

RSpec.describe User, type: :model do

    let(:subject) { FactoryGirl.create(:user) }

    it { expect(subject).to validate_presence_of(:name) }
    it { expect(subject).to validate_presence_of(:email) }
    it { expect(subject).to validate_presence_of(:password) }
    it { expect(subject).to validate_presence_of(:password_confirmation) }

    it { expect(subject).to have_many :ratings }
    it { expect(subject).to have_many :orders }

end
