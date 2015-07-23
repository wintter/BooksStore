FactoryGirl.define do
  factory :cart_item do
    book Book.first
  end

end
