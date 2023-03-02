FactoryBot.define do
  factory :transaction do
    pokemon_id { 6 }
    pokemon_name { 'Charizard' }
    pokemon_base_experience { 267 }
    usd_amount { 0.06 }
    btc_amount { 0.000001 }
    sold { false }
    operation { 'bought' }

    association :wallet, factory: :wallet

    trait :sold do
      sold { true }
      operation { 'sold' }
    end

    trait :bought do
      sold { false }
      operation { 'bought' }
    end
  end
end
