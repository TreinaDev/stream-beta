FactoryBot.define do
  factory :video_category do
    title { FFaker::Game.category }
    parent { nil }
  end
end
