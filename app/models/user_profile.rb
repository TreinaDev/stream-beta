class UserProfile < ApplicationRecord
  belongs_to :user

  validates :full_name, :social_name, :birth_date, :cpf, :zipcode, :address_line_one,
            :address_line_two, :city, :state, :country, presence: true
  validates :user_id, uniqueness: true
  validates :cpf, uniqueness: { case_sensitive: false }

  validate :check_cpf_format

  def create_or_update_account_holder
    account_holder = {
      name: full_name,
      cpf: cpf,
      birth_date: birth_date
    }

    data = ApiPagapaga.post('account_holders', account_holder.to_json)

    return data[:ok] if data&.key?(:ok)

    errors.add(:api_connection, data[:message])
  end

  private

  def check_cpf_format
    errors.add(:cpf, 'não é válido') unless CPF.valid?(cpf)
  end
end
