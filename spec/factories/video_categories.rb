FactoryBot.define do
  factory :video_category do
    title { FFaker::Game.category }
  end
end
