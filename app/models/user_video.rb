class UserVideo < ApplicationRecord
  belongs_to :user
  belongs_to :video
  has_one :product_receipt, as: :product, dependent: :restrict_with_error

  enum status: { pending: 10, approved: 50, rejected: 90 }

  def confirm_payment
    purchase_params = { payment_method_token: payment_method_token, product_token: product_token }
    data = ApiPagapaga.post('product_purchase', purchase_params.to_json)

    unless data&.key?(:payment_status)
      errors.add(:api_connection, data[:message])
      return nil
    end

    change_status(data[:payment_status])

    save_receipt(data[:receipt_token]) if save && approved?
  end

  def change_status(payment_status)
    if %w[approved pending rejected].include?(payment_status)
      self.status = payment_status.to_sym
    else
      errors.add(:status, 'inválida')
    end
  end

  private

  def save_receipt(receipt_token)
    receipt = build_product_receipt(user: user, receipt_token: receipt_token,
                                    payment_method: user.payment_methods.find_by(token: payment_method_token),
                                    value: video.value, receipt_date: Time.current)

    receipt.save
  end
end
