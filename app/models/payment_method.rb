class PaymentMethod < ApplicationRecord
  belongs_to :user

  enum payment_type: { pix: 10, boleto: 20, credit_card: 30 }

  validates :token, format: { with: /\A[a-zA-Z0-9]{10}\z/ }

  def request_token(user_payment_method)
    self.token = generate_new_token(user_payment_method.to_json) if token.nil?
  end

  private

  def generate_new_token(user_payment_method)
    result = nil

    response = Faraday.post('http://localhost:4000/api/v1/payment_methods/', user_payment_method)

    if response.status == 201
      data = JSON.parse(response.body, symbolize_names: true)
      result = data[:payment_method_token]
    end

    result
  end
end
