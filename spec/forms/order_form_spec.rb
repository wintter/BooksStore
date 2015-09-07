require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  let!(:order) { FactoryGirl.create(:order) }
  let(:subject) { OrderForm.new(order) }

  it { expect(subject).to respond_to(:billing_address) }
  it { expect(subject).to respond_to(:shipping_address) }
  it { expect(subject).to respond_to(:delivery) }
  it { expect(subject).to respond_to(:credit_card) }

  describe '#create_address' do
    let(:billing) { FactoryGirl.attributes_for(:address) }
    let(:shipping) { FactoryGirl.attributes_for(:address) }

    context 'address updated' do

      before do
        order.billing_address = FactoryGirl.create(:address)
        order.shipping_address = FactoryGirl.create(:address)
      end

      it '#update with hash' do
        subject.create_addresses(billing, shipping)
        expect(to_hash(subject.billing_address.attributes)) == billing
        expect(to_hash(subject.shipping_address.attributes)) == shipping
      end

      it 'not create additional two addresses if update' do
        expect{subject.create_addresses(billing, shipping)}.not_to change{ Address.count }
      end

    end

    context 'address created' do

      it 'create by hash' do
        subject.create_addresses(billing, shipping)
        expect(to_hash(subject.billing_address.attributes)) == billing
        expect(to_hash(subject.shipping_address.attributes)) == shipping
      end

      it 'create two new addresses' do
        expect{subject.create_addresses(billing, shipping)}.to change{ Address.count }.from(0).to(2)
      end
    end

  end

  describe '#create_credit_card' do
    let(:credit_card) { FactoryGirl.attributes_for(:credit_card) }

    context 'credit card updated' do

      before { order.credit_card = FactoryGirl.create(:credit_card) }

      it '#update with hash' do
        subject.create_credit_card(credit_card)
        expect(to_hash(subject.credit_card.attributes)) == credit_card
      end

      it 'not create additional credit card if update' do
        expect{subject.create_credit_card(credit_card)}.not_to change{ CreditCard.count }
      end

    end

    context 'credit card created' do

      it 'create by hash' do
        subject.create_credit_card(credit_card)
        expect(to_hash(subject.credit_card.attributes)) == credit_card
      end

      it 'create two new addresses' do
        expect{subject.create_credit_card(credit_card)}.to change{CreditCard.count}.from(0).to(1)
      end
    end

  end

  describe '#create_delivery' do
    let(:delivery) { FactoryGirl.create(:delivery) }
    let(:params_delivery) { { id: delivery.id } }

    context 'delivery updated' do

      before { order.delivery = delivery }

      it '#update with delivery' do
        expect(order).to receive(:update).with(delivery_id: delivery.id)
        subject.create_delivery(params_delivery)
      end

    end

    context 'delivery created' do
      it 'add delivery to order' do
        subject.create_delivery(params_delivery)
        expect(order.delivery).to eq delivery
      end
    end

  end

  describe '#update' do

    before do
      @params = { billing_address: FactoryGirl.attributes_for(:address),
                  shipping_address: FactoryGirl.attributes_for(:address),
                  delivery: '1',
                  credit_card: FactoryGirl.create(:credit_card)}
    end

    it 'create address if address step' do
      expect(subject).to receive(:create_addresses).with(@params[:billing_address], @params[:shipping_address])
      subject.update(:order_address, @params)
    end

    it 'create delivery if delivery step' do
      expect(subject).to receive(:create_delivery).with(@params[:delivery])
      subject.update(:order_delivery, @params)
    end

    it 'create credit card if credit card step' do
      expect(subject).to receive(:create_credit_card).with(@params[:credit_card])
      subject.update(:order_payment, @params)
    end

    it 'create order if valid all previous step' do
      expect(order).to receive(:create)
      subject.update(:order_confirm, @params)
    end
  end

  describe '#save' do

    it 'create order' do
      expect(order).to receive(:save)
      subject.save
    end
  end

  def to_hash(hash)
    hash.each do |key, v|
      hash.delete(key) if ["id", "created_at", "updated_at"].include? key
    end
    hash
  end

end
