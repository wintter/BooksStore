FactoryGirl.define do
  factory :cart_item do
    quantity 1
    book
    cart
  end

end
