FactoryBot.define do
  factory :video do
    title { FFaker::Game.title }
    duration { FFaker::String.from_regexp(/0\d:[0-5]\d:[0-5]\d/) }
    video_url { FFaker::String.from_regexp(/\d{9}/) }
    maturity_rating { %w[L 10 12 14 16 18].sample }

    streamer

    trait :allow_purchase do
      allow_purchase { true }
      value { rand(1..10) }
      token { SecureRandom.alphanumeric(10) }
    end
  end
end
