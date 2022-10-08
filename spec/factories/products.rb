FactoryBot.define do
  factory :product do
    name { Faker::Name.first_name }
    cost { 100 }
    seller
  end
end
