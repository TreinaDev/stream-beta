class PaymentMethod < ApplicationRecord
  attr_writer :user_payment_method

  belongs_to :user

  enum payment_type: { pix: 10, boleto: 20, credit_card: 30 }

  validates :token, presence: true
  validates :token, uniqueness: true
  validates :token, format: { with: /\A[a-zA-Z0-9]{10}\z/ }

  before_validation :request_token

  def self.available_payment_methods
    available_payment_methods = ApiPagapaga.get('available_payment_methods')

    return [] if available_payment_methods.empty?

    return available_payment_methods if contains_error_message?(available_payment_methods)

    available_payment_methods.pluck(:payment_type)
  end

  def translated_payment_type
    I18n.t(payment_type)
  end

  def request_token
    return unless token.nil? && @user_payment_method.present?

    @user_payment_method.remove_instance_variable(:@attribute_errors)
    self.token = generate_new_token(@user_payment_method.to_json)
  end

  private

  def generate_new_token(user_payment_method)
    data = ApiPagapaga.post('payment_methods', user_payment_method)

    unless data&.key?(:payment_method_token)
      errors.add(:api_connection, data[:message])
      return nil
    end

    data[:payment_method_token]
  end

  private_class_method def self.contains_error_message?(available_payment_methods)
    (available_payment_methods.is_a?(Array) && available_payment_methods&.first&.key?(:message)) ||
    (available_payment_methods.is_a?(Hash) && available_payment_methods&.key?(:message))
  end
end
