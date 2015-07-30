FactoryGirl.define do
  # This will use the User class (Admin would have been guessed)
  factory :address do
    street_address Faker::Address.street_name
    city Faker::Address.city
    phone Faker::PhoneNumber.cell_phone
    zip Faker::Address.zip
  end
end