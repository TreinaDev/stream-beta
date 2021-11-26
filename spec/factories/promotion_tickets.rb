FactoryBot.define do
  factory :promotion_ticket do
    title { 'MyString' }
    start_date { '2021-11-26' }
    end_date { '2021-11-26' }
    discount { '9.99' }
    maximum_value_reduction { '9.99' }
  end
end
