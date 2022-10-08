FactoryBot.define do
  factory :user do
    username { Faker::Name.first_name }
    password { 'q123q123' }
  end

  factory :buyer, parent: :user do
    role {'buyer'}
  end

  factory :seller, parent: :user do
    role {'seller'}
  end
end
