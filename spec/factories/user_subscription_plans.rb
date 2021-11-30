FactoryBot.define do
  factory :user_subscription_plan do
    product_token { SecureRandom.alphanumeric(10) }
    payment_method_token { SecureRandom.alphanumeric(10) }
  end
end
