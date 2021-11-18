FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { '123456' }

    trait :admin do
      email { "#{FFaker::Internet.user_name}@gamestream.com.br" }
    end
  end
end
