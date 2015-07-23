FactoryGirl.define do

  factory :rating do
    review Faker::Company.suffix
    rating_number Faker::Number.digit
    approve false
  end

end