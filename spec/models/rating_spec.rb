require 'rails_helper'

RSpec.describe Rating, type: :model do

  let(:subject) { FactoryGirl.create(:rating) }

  it { expect(subject).to belong_to :user }
  it { expect(subject).to belong_to :book }

  context '.get_rate' do
    let(:book) { FactoryGirl.create(:book) }
    let(:user) { FactoryGirl.create(:user) }

    it '#where with book and user' do
      allow(Rating).to receive_message_chain(:where, :first)
      expect(Rating).to receive(:where).with(book: book, user: user)
      Rating.get_rate(book, user)
    end

    it 'return 0 if not exist' do
      expect(Rating.get_rate(book, user)).to eq 0
    end

    it 'return not 0 if exist' do
      subject.update(user: user, book: book, rating_number: 10)
      expect(Rating.get_rate(book, user)).not_to eq 0
    end

  end

  context '.get_review' do
    let(:book) { FactoryGirl.create(:book) }

    before do
      allow(Rating).to receive_message_chain(:where, :all)\
    end

    it '#where with book and approve' do
      expect(Rating).to receive(:where).with(book: book, approve: true)
      Rating.get_review(book)
    end

  end

end
