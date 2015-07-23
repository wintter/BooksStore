require 'rails_helper'

RSpec.describe Author, type: :model do

  let(:subject) { FactoryGirl.create(:author) }

  it { expect(subject).to validate_presence_of :firstname }
  it { expect(subject).to validate_presence_of :lastname }
  it { expect(subject).to respond_to :biography }

  it { expect(subject).to have_many(:books)}

end
