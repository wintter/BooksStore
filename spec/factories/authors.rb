FactoryGirl.define do

  factory :author do
    firstname Faker::Name.name
    lastname Faker::Name.name
    biography Faker::Lorem.paragraph
  end

end