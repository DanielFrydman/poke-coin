FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { '123456' }

    trait :with_wallet do
      association(:wallet, factory: :wallet)
    end
  end
end
