require 'rails_helper'

RSpec.describe Rating, type: :model do

  let(:subject) { FactoryGirl.create(:rating) }
  let(:book) { FactoryGirl.create(:book) }

  it { expect(subject).to belong_to :user }
  it { expect(subject).to belong_to :book }

  context 'scope approved' do

    it 'includes rating with filled review' do
      expect(Rating.approved).to match_array subject
    end

    it 'not include rating with empty review' do
      subject.update(review: nil)
      expect(Rating.approved).not_to match_array subject
    end

  end

end
