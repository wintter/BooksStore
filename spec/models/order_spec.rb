require 'rails_helper'

RSpec.describe Order, type: :model do

  let(:subject) { FactoryGirl.create(:order) }
  let(:user) { FactoryGirl.create(:user) }


  let(:cart) { FactoryGirl.create(:order, user: user) }

  it { expect(subject).to have_many :order_items }
  it { expect(subject).to belong_to :user }
  it { expect(subject).to belong_to :credit_card }
  it { expect(subject).to belong_to :address }
  it { expect(subject).to belong_to :delivery }
  it { expect(subject).to belong_to :coupon }

  context 'scope .cart' do

    it 'return users cart' do
      expect(Order.cart(user)).to match_array(cart)
    end

  end


end
