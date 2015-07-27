require 'rails_helper'

RSpec.describe Rating, type: :model do

  let(:subject) { FactoryGirl.create(:rating) }
  let(:book) { FactoryGirl.create(:book) }

  it { expect(subject).to belong_to :user }
  it { expect(subject).to belong_to :book }

  context '.number' do
    let(:user) { FactoryGirl.create(:user) }

    it '#where with book and user' do
      allow(Rating).to receive_message_chain(:where, :first)
      expect(Rating).to receive(:where).with(book: book, user: user)
      Rating.number(book, user)
    end

    it 'return 0 if not exist' do
      expect(Rating.number(book, user)).to eq 0
    end

    it 'return not 0 if exist' do
      subject.update(user: user, book: book, rating_number: 10)
      expect(Rating.number(book, user)).not_to eq 0
    end

  end

  context 'scope user_reviews' do

    it 'return approve ratings' do
      subject.update(book: book, approve: true)
      expect(Rating.user_reviews(book).count).to eq 1
    end

    it 'return 0 if no approve' do
      expect(Rating.user_reviews(subject.book).count).to eq 0
    end

  end

end
