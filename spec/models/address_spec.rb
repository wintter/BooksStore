require 'rails_helper'

RSpec.describe Address, type: :model do

  let(:subject) { FactoryGirl.create(:address) }

  it { expect(subject).to validate_presence_of :billing_address }
  it { expect(subject).to validate_presence_of :shipping_address }
  it { expect(subject).to validate_presence_of :city }

  xit 'need test format'

  it { expect(subject).to have_one :order }

end
