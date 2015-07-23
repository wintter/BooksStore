FactoryGirl.define do
  # This will use the User class (Admin would have been guessed)
  factory :address do
    billing_address Faker::Address.street_name
    shipping_address Faker::Address.street_name
    city Faker::Address.city
    phone Faker::PhoneNumber.cell_phone
    zip Faker::Address.zip
  end
end