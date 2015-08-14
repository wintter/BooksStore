require 'rails_helper'

RSpec.describe Order, type: :model do

  let(:subject) { FactoryGirl.create(:order) }
  let(:user) { FactoryGirl.create(:user) }

  it { expect(subject).to have_many :order_items }
  it { expect(subject).to belong_to :user }
  it { expect(subject).to belong_to :credit_card }
  it { expect(subject).to belong_to :billing_address }
  it { expect(subject).to belong_to :shipping_address }
  it { expect(subject).to belong_to :delivery }
  it { expect(subject).to belong_to :coupon }

  context 'scope .valid_order' do
    let!(:order_in_progress) { FactoryGirl.create(:order, user: user) }
    let!(:order_in_queue) { FactoryGirl.create(:order, user: user, state: 'in_queue') }
    let!(:order_in_delivery) { FactoryGirl.create(:order, user: user, state: 'in_delivery') }
    let!(:order_delivered) { FactoryGirl.create(:order, user: user, state: 'delivered') }
    let!(:order_canceled) { FactoryGirl.create(:order, user: user, state: 'canceled') }

    it 'not return order in_progress' do
      expect(Order.valid_orders).not_to include order_in_progress
    end

    it 'not return order canceled' do
      expect(Order.valid_orders).not_to include order_canceled
    end

    it 'return order in_queue' do
      expect(Order.valid_orders).to include order_in_queue
    end

    it 'return order in_delivery' do
      expect(Order.valid_orders).to include order_in_delivery
    end

    it 'return order delivered' do
      expect(Order.valid_orders).to include order_delivered
    end

  end

  context 'AASM' do

    it 'by default have in_progress state' do
      expect(subject.state).to eq 'in_progress'
    end

    it '#checkout transitions from in_progress to in_queue' do
      subject.checkout!
      expect(subject.state).to eq 'in_queue'
    end

    it '#confirm transitions from in_queue to in_delivery' do
      subject.checkout!
      subject.confirm!
      expect(subject.state).to eq 'in_delivery'
    end

    it '#finish transitions from in_delivery to delivered' do
      allow(OrderMailer).to receive_message_chain(:order_delivered, :deliver_now)
      subject.checkout!
      subject.confirm!
      subject.finish!
      expect(subject.state).to eq 'delivered'
    end

    it '#cancel transitions from in_queue, in_delivery, delivered to canceled' do
      subject.checkout!
      subject.cancel!
      expect(subject.state).to eq 'canceled'
    end

  end

  context '#next_state' do
    let!(:order_in_queue) { FactoryGirl.create(:order, user: user, state: 'in_queue') }
    let!(:order_in_delivery) { FactoryGirl.create(:order, user: user, state: 'in_delivery') }

    it '#confirm! if state in_progress' do
      order_in_queue.next_state
      expect(order_in_queue.state).to eq 'in_delivery'
    end

    it '#finish! if state in_delivery' do
      order_in_delivery.next_state
      expect(order_in_delivery.state).to eq 'delivered'
    end

  end

  context '#send_email' do
    it 'OrderMailer receive #order_delivered, #deliver_now' do
      expect(OrderMailer).to receive_message_chain(:order_delivered, :deliver_now)
      subject.send_email
    end
  end

end
