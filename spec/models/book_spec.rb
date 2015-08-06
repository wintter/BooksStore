require 'rails_helper'

RSpec.describe Book, type: :model do

  let(:subject) { FactoryGirl.create(:book) }
  let(:user) { FactoryGirl.create(:user) }

  it { expect(subject).to validate_presence_of(:title) }
  it { expect(subject).to validate_presence_of(:description) }
  it { expect(subject).to validate_presence_of(:price) }
  it { expect(subject).to validate_presence_of(:in_stock) }

  it { expect(subject).to have_many :ratings }
  it { expect(subject).to belong_to :author }
  it { expect(subject).to belong_to :category }

  context '.search' do

    it 'find with by_text scope' do
      expect(Book).to receive(:by_text)
      Book.search '1', 'qwe'
    end

    it 'find with by_author scope' do
      expect(Author).to receive(:by_author)
      Book.search '2', 'qwe'
    end

    it '#where with author' do
      expect(Book).to receive(:where).with(author: [])
      Book.search '2', 'qwe'
    end

  end

  context '#number' do
    let(:rating) { FactoryGirl.create(:rating, rating_number: 10, user: user, approve: true) }

    it 'rating 0 if not exist' do
       expect(subject.number(user)).to eq 0
    end

    it 'rating if exist' do
      rating.update(book: subject)
      expect(subject.number(user)).to eq 10
    end

  end

  context '#reviews' do
    let(:rating) { FactoryGirl.create(:rating, approve: true, book: subject) }

    it { expect(subject.reviews).to match_array(rating) }
  end

end
