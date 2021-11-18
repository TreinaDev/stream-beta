FactoryBot.define do
  factory :subscription_plan do
    title { FFaker::Game.category }
    description { 'Descrição padrão' }
    value { '9.99' }
  end
end
