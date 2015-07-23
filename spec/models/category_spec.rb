require 'rails_helper'

RSpec.describe Category, type: :model do

  let(:subject) { FactoryGirl.create(:category) }

  it { expect(subject).to validate_presence_of :title }

  it { expect(subject).to have_many(:books)}

end
