FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { '123456' }

    trait :admin do
      email { "#{FFaker::Internet.user_name}@gamestream.com.br" }
    end

    transient do
      create_profile { false }
    end

    after :create do |user, options|
      create(:user_profile, user: user) if options.create_profile
    end
  end
end
