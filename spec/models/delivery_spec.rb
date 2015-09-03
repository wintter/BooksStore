require 'rails_helper'

RSpec.describe Delivery, type: :model do
  it { expect(subject).to have_one :order }
end
