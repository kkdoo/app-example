FactoryGirl.define do
  factory :charge do
    amount { Random.rand(10000) }
    currency 'usd'
    customer

    trait :successful do
      paid true
      refunded false
    end
    trait :disputed do
      paid true
      refunded true
    end
  end
end
