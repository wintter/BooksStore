require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  let!(:order) { FactoryGirl.create(:order) }
  let(:subject) { OrderForm.new(order) }

  it { expect(subject).to respond_to(:billing_address) }
  it { expect(subject).to respond_to(:shipping_address) }
  it { expect(subject).to respond_to(:delivery) }
  it { expect(subject).to respond_to(:credit_card) }

  describe '#create_address' do
    before do
      @billing = FactoryGirl.attributes_for(:address)
      @shipping = FactoryGirl.attributes_for(:address)
    end

    context 'address updated' do
      before do
        order.billing_address = FactoryGirl.create(:address)
        order.shipping_address = FactoryGirl.create(:address)
      end

      it '#update with hash' do
        subject.create_addresses(@billing, @shipping)
        expect(to_hash(subject.billing_address.attributes)) == @billing
        expect(to_hash(subject.shipping_address.attributes)) == @shipping
      end

    end

    context 'address created' do
      it 'billing and shipping' do
        subject.create_addresses(@billing, @shipping)
        expect(to_hash(subject.billing_address.attributes)) == @billing
        expect(to_hash(subject.shipping_address.attributes)) == @shipping
      end
    end

  end

  def to_hash(hash)
    hash.each do |key, v|
      hash.delete(key) if ["id", "created_at", "updated_at"].include? key
    end
    hash
  end

end
