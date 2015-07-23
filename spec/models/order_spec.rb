require 'rails_helper'

RSpec.describe Order, type: :model do

  let(:subject) { FactoryGirl.create(:order) }
  let(:user) { FactoryGirl.create(:user) }
  let(:delivery) { '5' }

  it { expect(subject).to have_many :order_items }
  it { expect(subject).to belong_to :user }
  it { expect(subject).to belong_to :credit_card }
  it { expect(subject).to belong_to :order_state }
  it { expect(subject).to belong_to :address }

  context '#create_order' do

    before do
      allow(Order).to receive(:get_total_price)
    end

    let(:address) { FactoryGirl.attributes_for(:address) }
    let(:credit_card) { FactoryGirl.attributes_for(:credit_card) }

    it 'Order receive #get_total_price' do
      expect(Order).to receive(:get_total_price)
      subject.create_order(user, address, credit_card, delivery)
    end

    it 'call #total_price' do
      expect(subject).to receive(:total_price)
      subject.create_order(user, address, credit_card, delivery)
    end

    it 'call #create_credit_card' do
      expect(subject).to receive(:create_credit_card)
      subject.create_order(user, address, credit_card, delivery)
    end

    it 'call #create_address' do
      expect(subject).to receive(:create_address)
      subject.create_order(user, address, credit_card, delivery)
    end

  end

  context '.get_total_price' do

    before do
      allow(Cart).to receive_message_chain(:where, :first, :cart_items, :map, :inject, :+)
    end

    it '#where with user' do
      expect(Cart).to receive(:where).with(user: user)
      Order.get_total_price(user, delivery)
    end

  end

end
