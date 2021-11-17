FactoryBot.define do
  factory :playlist do
    title { FFaker::Game.category }
    description { FFaker::LoremBR.paragraph }
  end
end
