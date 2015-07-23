require 'rails_helper'

RSpec.describe OrderItem, type: :model do

  let(:subject) { FactoryGirl.create(:order_item) }

  it { expect(subject).to validate_presence_of(:quantity) }

  it { expect(subject).to belong_to :book }
  it { expect(subject).to belong_to :order }

end
