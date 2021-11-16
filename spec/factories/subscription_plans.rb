FactoryBot.define do
  factory :subscription_plan do
    sequence(:title) { |n| "plano #{n}" }
    description { 'Descrição padrão' }
    value { '9.99' }
  end
end
