class PaymentMethod < ApplicationRecord
  belongs_to :user

  enum payment_type: { pix: 10, boleto: 20, credit_card: 30 }

  before_validation :fill_token

  validates :token, format: { with: /\A[a-zA-Z0-9]{10}\z/ }

  def fill_token
    self.token = generate_new_token if token.nil?
  end

  def generate_new_token
    # TODO: Comunicar com API
    nil
  end
end
