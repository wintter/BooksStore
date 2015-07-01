require 'rails_helper'

RSpec.describe Rating, type: :model do

  let(:subject) { FactoryGirl.create(:rating) }

  it { expect(subject).to validate_inclusion_of(:rating_number).in_range(1..10) }

  it { expect(subject).to belong_to :user }
  it { expect(subject).to belong_to :book }

end
