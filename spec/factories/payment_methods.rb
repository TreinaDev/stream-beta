FactoryBot.define do
  factory :payment_method do
    token { SecureRandom.alphanumeric(10) }
    user { nil }
  end
end
