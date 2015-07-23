require 'rails_helper'

RSpec.describe Cart, type: :model do

  it { expect(subject).to belong_to(:user)}
  it { expect(subject).to have_many(:cart_items)}

end
