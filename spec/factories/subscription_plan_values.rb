FactoryBot.define do
  factory :subscription_plan_value do
    start_date { Date.current }
    end_date { 7.days.from_now }
    value { '9.99' }
    subscription_plan
  end
end
