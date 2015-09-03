require 'rails_helper'

RSpec.describe Ability, type: :model do

  describe 'abilities for not login user' do

    let(:user) { FactoryGirl.create(:user) }
    let(:another_user) { FactoryGirl.create(:user) }
    let(:order) { FactoryGirl.create(:order, user: user) }

    subject { Ability.new(user) }

    context 'Book ability' do
      it { expect(subject).to be_able_to(:index, Book) }
      it { expect(subject).to be_able_to(:show, Book) }
      it { expect(subject).to be_able_to(:add_to_wish_list, Book) }
      it { expect(subject).to be_able_to(:add_to_cart, Book) }
    end

    context 'Rating ability' do
      it { expect(subject).to be_able_to(:create, Rating.new(user: user)) }

      it { expect(subject).not_to be_able_to(:create, Rating.new(user: another_user)) }
    end

    context 'WishList ability' do
      it { expect(subject).to be_able_to(:manage, WishList.new(user: user)) }

      it { expect(subject).not_to be_able_to(:manage, WishList.new(user: another_user)) }
    end

    context 'Order ability' do
      it { expect(subject).to be_able_to(:index, Order.new(user: user)) }
      it { expect(subject).to be_able_to(:show, Order.new(user: user)) }
      it { expect(subject).to be_able_to(:create, Order.new(user: user)) }
      it { expect(subject).to be_able_to(:update, Order.new(user: user)) }
      it { expect(subject).to be_able_to(:coupon, Order.new(user: user)) }

      it { expect(subject).not_to be_able_to(:index, Order.new(user: another_user)) }
      it { expect(subject).not_to be_able_to(:show, Order.new(user: another_user)) }
      it { expect(subject).not_to be_able_to(:create, Order.new(user: another_user)) }
      it { expect(subject).not_to be_able_to(:update, Order.new(user: another_user)) }
      it { expect(subject).not_to be_able_to(:coupon, Order.new(user: another_user)) }
    end

    context 'OrderItem ability' do
      it { expect(subject).to be_able_to(:manage, OrderItem.new(order: user.cart)) }
    end

  end

end
