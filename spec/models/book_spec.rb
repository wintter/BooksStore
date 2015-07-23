require 'rails_helper'

RSpec.describe Book, type: :model do

  let(:subject) { FactoryGirl.create(:book) }

  it { expect(subject).to validate_presence_of(:title) }
  it { expect(subject).to validate_presence_of(:description) }
  it { expect(subject).to validate_presence_of(:price) }
  it { expect(subject).to validate_presence_of(:in_stock) }

  it { expect(subject).to have_many :ratings }
  it { expect(subject).to belong_to :author }
  it { expect(subject).to belong_to :category }
  it { expect(subject).to have_and_belong_to_many :users }

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

  context '.save_image' do

    before do
      @file = fixture_file_upload('files/test.png', 'image/png')
    end

    xit 'read file' do
      expect(MiniMagick::Image).to receive(:read)
      Book.save_image @file, 1
    end

  end

end
