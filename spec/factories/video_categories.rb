FactoryBot.define do
  factory :video_category do
    title { FFaker::Game.category.to_s }
  end
end
