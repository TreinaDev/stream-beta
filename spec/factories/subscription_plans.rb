FactoryBot.define do
  factory :subscription_plan do
    transient do
      generate_token { true }
    end

    title { FFaker::Game.category }
    description { FFaker::LoremBR.phrase }
    value { FFaker::Number.decimal }
    token { SecureRandom.alphanumeric(10).upcase if generate_token }

    trait :playlist do
      plan_type { :playlist }
    end

    trait :streamer do
      plan_type { :streamer }
    end
  end
end
