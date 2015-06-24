require 'rails_helper'

RSpec.describe Book, type: :model do

  let(:subject) { FactoryGirl.create(:book) }

  it { expect(subject).to validate_presence_of(:title) }
  it { expect(subject).to validate_presence_of(:price) }
  it { expect(subject).to validate_presence_of(:in_stock) }

  it { expect(subject).to have_many :ratings }
  it { expect(subject).to belong_to :author }
  it { expect(subject).to belong_to :category }

end
