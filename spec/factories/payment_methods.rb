FactoryBot.define do
  factory :payment_method do
    token { 'MyString' }
    user { nil }
  end
end
