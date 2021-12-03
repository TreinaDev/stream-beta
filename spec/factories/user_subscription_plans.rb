FactoryBot.define do
  factory :user_subscription_plan do
    transient do
      subscription_plan_token { SecureRandom.alphanumeric(10).upcase }
    end

    product_token { subscription_plan_token }
    payment_method_token { SecureRandom.alphanumeric(10).upcase }

    user
    subscription_plan { association :subscription_plan, token: subscription_plan_token }
  end
end
