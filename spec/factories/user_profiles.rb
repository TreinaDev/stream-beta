FactoryBot.define do
  factory :user_profile do
    full_name { FFaker::AddressBR.name.to_s }
    social_name { FFaker::AddressBR.name.to_s }
    birth_date { FFaker::Time.date - 20.years }
    cpf { CPF.generate }
    zipcode { FFaker::AddressBR.zip_code.to_s }
    address_line_one { "#{FFaker::AddressBR.street}, #{FFaker::AddressBR.building_number}" }
    address_line_two { FFaker::AddressBR.neighborhood.to_s }
    city { FFaker::AddressBR.city.to_s }
    state { FFaker::AddressBR.state.to_s }
    country { FFaker::AddressBR.country.to_s }
    user
  end
end
