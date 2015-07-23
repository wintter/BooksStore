require 'rails_helper'

RSpec.describe CartItem, type: :model do

  it { expect(subject).to belong_to(:book)}
  it { expect(subject).to belong_to(:cart)}

end
