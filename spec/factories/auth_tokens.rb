FactoryBot.define do
  factory :auth_token do
    token { Faker::Number.number(digits: 12).to_s }
  end
end
