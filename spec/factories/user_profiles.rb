FactoryBot.define do
  factory :user_profile do
    full_name { "MyString" }
    social_name { "MyString" }
    birth_date { "2021-11-17" }
    cpf { "MyString" }
    zipcode { "MyString" }
    address_line_1 { "MyString" }
    address_line_2 { "MyString" }
    city { "MyString" }
    state { "MyString" }
    country { "MyString" }
    user { nil }
  end
end
