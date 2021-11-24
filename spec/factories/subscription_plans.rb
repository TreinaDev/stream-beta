FactoryBot.define do
  factory :subscription_plan do
    title { FFaker::Game.category }
    description { FFaker::LoremBR.phrase }
    value { FFaker::Number.decimal }
    token { SecureRandom.alphanumeric(10) }

    trait :playlist do
      plan_type { :playlist }
    end

    trait :streamer do
      plan_type { :streamer }
    end
  end
end
