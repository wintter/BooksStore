require 'rails_helper'

RSpec.describe Address, type: :model do

  let(:subject) { FactoryGirl.create(:address) }

  it { expect(subject).to validate_presence_of :street_address }
  it { expect(subject).to validate_presence_of :city }
  it { expect(subject).to validate_presence_of :phone }
  it { expect(subject).to validate_presence_of :zip }

  it { expect(subject.phone).to match(/\d/) }
  it { expect(subject.zip).to match(/\d/) }

  it { expect(subject).to have_one :order }

end
