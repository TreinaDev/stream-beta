FactoryBot.define do
  factory :promotion_ticket do
    title { 'MyString' }
    start_date { 1.day.from_now }
    end_date { 2.days.from_now }
    discount { rand(1..50) }
    maximum_value_reduction { rand(1..100) }
    maximum_uses { rand(1..5) }
  end
end
