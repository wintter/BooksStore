FactoryGirl.define do
  factory :user do
    name     Faker::Internet.user_name
    sequence(:email, 1000) { |n| "person#{n}@example.com" }
    password "123456"
    password_confirmation "123456"
  end
end