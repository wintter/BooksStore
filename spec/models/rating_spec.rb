require 'rails_helper'

RSpec.describe Rating, type: :model do

  let(:subject) { FactoryGirl.create(:rating) }
  let(:book) { FactoryGirl.create(:book) }

  it { expect(subject).to belong_to :user }
  it { expect(subject).to belong_to :book }

end
