FactoryGirl.define do

  factory :book do
    title    { Faker::Commerce.product_name }
    description    { Faker::Commerce.product_name }
    price    { Faker::Number.number(4) }
    in_stock { Faker::Number.number(3) }
    publication_date { Faker::Time.between(DateTime.now - 1, DateTime.now) }
    category
    author
  end

end