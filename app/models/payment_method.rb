class PaymentMethod < ApplicationRecord
  belongs_to :user

  enum payment_type: { pix: 10, boleto: 20, credit_card: 30 }

  validates :token, format: { with: /\A[a-zA-Z0-9]{10}\z/ }

  def request_token(user_payment_method)
    self.token = generate_new_token(user_payment_method) if token.nil?
  end

  private

  def generate_new_token(_user_payment_method)
    # TODO: Comunicar com API
    nil
  end
end
