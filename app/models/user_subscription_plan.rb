class UserSubscriptionPlan < ApplicationRecord
  belongs_to :user
  belongs_to :subscription_plan
  has_many :product_receipts, as: :product, dependent: :restrict_with_error

  enum status: { pending: 10, approved: 50, rejected: 90 }
  enum enrollment: { active: 100, canceled: 150 }

  def confirm_payment
    purchase_params = { subscription_product_payment: { payment_method_token: payment_method_token,
                                                        product_token: product_token } }
    data = ApiPagapaga.post('subscription_product_payments', purchase_params.to_json)

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
    receipt = product_receipts.new(user: user, receipt_token: receipt_token,
                                   payment_method: user.payment_methods.find_by(token: payment_method_token),
                                   value: subscription_plan.value, receipt_date: Time.current)

    receipt.save
  end
end
