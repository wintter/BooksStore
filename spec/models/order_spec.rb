require 'rails_helper'

RSpec.describe Order, type: :model do

  let(:subject) { FactoryGirl.create(:order) }
  let(:user) { FactoryGirl.create(:user) }
  let(:cart) { user.cart = FactoryGirl.create(:cart) }
  let(:delivery) { '5' }

  it { expect(subject).to have_many :order_items }
  it { expect(subject).to belong_to :user }
  it { expect(subject).to belong_to :credit_card }
  it { expect(subject).to belong_to :order_state }
  it { expect(subject).to belong_to :address }

  context '#create_order' do

    before do
      allow(Order).to receive(:get_total_price)
      cart.cart_items.push FactoryGirl.create(:cart_item)
    end

    let(:address) { FactoryGirl.attributes_for(:address) }
    let(:credit_card) { FactoryGirl.attributes_for(:credit_card) }

    it 'Order receive #get_total_price' do
      expect(Order).to receive(:get_total_price)
      subject.create_order(user, address, credit_card, delivery, cart)
    end

    it 'call #total_price' do
      expect(subject).to receive(:total_price)
      subject.create_order(user, address, credit_card, delivery, cart)
    end

    it 'call #create_credit_card' do
      expect(subject).to receive(:create_credit_card)
      subject.create_order(user, address, credit_card, delivery, cart)
    end

    it 'call #create_address' do
      expect(subject).to receive(:create_address)
      subject.create_order(user, address, credit_card, delivery, cart)
    end

    it 'create order item' do
      expect(OrderItem).to receive(:create)
      subject.create_order(user, address, credit_card, delivery, cart)
    end

  end

end
