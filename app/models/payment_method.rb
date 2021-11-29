class PaymentMethod < ApplicationRecord
  attr_writer :user_payment_method

  belongs_to :user

  enum payment_type: { pix: 10, boleto: 20, credit_card: 30 }

  validates :token, presence: true
  validates :token, uniqueness: true
  validates :token, format: { with: /\A[a-zA-Z0-9]{10}\z/ }

  before_validation :request_token

  def request_token
    self.token = generate_new_token(@user_payment_method.to_json) if token.nil?
  end

  private

  def generate_new_token(user_payment_method)
    data = ApiClient.post('payment_methods', user_payment_method)

    unless data&.key?(:payment_method_token)
      errors.add(:api_connection, data[:message])
      return nil
    end

    data[:payment_method_token]
  end
end
