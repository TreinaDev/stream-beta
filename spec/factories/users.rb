FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "usuario#{n}@teste.com.br" }
    password { '123456' }

    trait :admin do
      sequence(:email) { |n| "administrador#{n}@gamestream.com.br" }
    end
  end
end
