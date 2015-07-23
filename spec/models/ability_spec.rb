require 'rails_helper'

RSpec.describe Ability, type: :model do

  describe 'abilities for not login user' do

    let(:user) { FactoryGirl.create(:user) }
    subject { Ability.new(user) }

    it 'can #index Author' do
      expect(subject).to be_able_to(:read, Author)
    end

    it 'can #index Rating' do
      expect(subject).to be_able_to(:create, Rating.new)
    end

    it 'can #index Book' do
      expect(subject).to be_able_to(:read, Book)
    end

  end

end
