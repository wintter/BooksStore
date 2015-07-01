require 'rails_helper'

RSpec.describe Order, type: :model do

  let(:subject) { FactoryGirl.create(:order) }

  it { expect(subject).to validate_inclusion_of(:state).in_array(%w(in\ progress completed shipped)) }

  it { expect(subject).to have_many :order_items }
  it { expect(subject).to belong_to :user }
  it { expect(subject).to belong_to :credit_card }
  it { expect(subject).to belong_to :billing_address }
  it { expect(subject).to belong_to :shipping_address }

  it "should set status in progress" do
    subject.state = nil
    subject.save
    expect(subject.state).to eq 'in progress'
  end

  it "#add_book with price 0" do
    expect(subject.total_price).to eq 0
  end

  it "#add_book with price 200" do
    book = FactoryGirl.create(:book, price: 100)
    subject.add_book book
    subject.add_book book
    subject.save
    expect(subject.total_price).to eq 200
  end

  it "should have date" do
    subject.save
    expect(subject.completed_date).not_to eq nil
  end

end
