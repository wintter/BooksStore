require 'rails_helper'

RSpec.describe Coupon, type: :model do
  let(:subject) { FactoryGirl.create(:coupon) }

  it { expect(subject).to have_many(:order)}
end
