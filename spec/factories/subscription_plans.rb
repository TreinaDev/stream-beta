FactoryBot.define do
  factory :subscription_plan do
    title { FFaker::Game.category }
    description { FFaker::LoremBR.phrase }
    value { FFaker::Number.decimal }
  end
end
