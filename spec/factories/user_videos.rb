FactoryBot.define do
  factory :user_video do
    transient do
      video_token { SecureRandom.alphanumeric(10).upcase }
    end

    product_token { video_token }
    payment_method_token { SecureRandom.alphanumeric(10).upcase }

    user
    video { association :video, :allow_purchase, token: video_token }
  end
end
