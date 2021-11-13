FactoryBot.define do
  factory :user do
    email { generate(:email) }
    password { '123456789' }
  end
end
