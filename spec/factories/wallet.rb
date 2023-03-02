FactoryBot.define do
  factory :wallet do
    usd_amount { 0.0 }
    btc_amount { 0.0 }
    association :user, factory: :user
  end
end