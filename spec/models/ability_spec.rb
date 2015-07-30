require 'rails_helper'

RSpec.describe Ability, type: :model do

  describe 'abilities for not login user' do

    let(:user) { FactoryGirl.create(:user) }
    subject { Ability.new(user) }

    context 'Book ability' do
      it { expect(subject).to be_able_to(:index, Book) }
      it { expect(subject).to be_able_to(:show, Book) }
      it { expect(subject).to be_able_to(:add_to_wish_list, Book) }
      it { expect(subject).to be_able_to(:add_to_cart, Book) }
    end

    context 'Rating ability' do
      it { expect(subject).to be_able_to(:create, Rating) }
    end

    context 'CartItem ability' do
      it { expect(subject).to be_able_to(:manage, CartItem) }
    end

    context 'WishList ability' do
      it { expect(subject).to be_able_to(:manage, WishList) }
    end

    context 'Order ability' do
      it { expect(subject).to be_able_to(:index, Order) }
      it { expect(subject).to be_able_to(:show, Order) }
      it { expect(subject).to be_able_to(:create, Order) }
      it { expect(subject).to be_able_to(:update, Order) }
    end

  end

end
