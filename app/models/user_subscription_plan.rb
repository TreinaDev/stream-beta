class UserSubscriptionPlan < ApplicationRecord
  belongs_to :user
  belongs_to :subscription_plan
  has_many :product_receipts, as: :product, dependent: :restrict_with_error

  enum status: { pending: 10, approved: 50, rejected: 90 }

  # TODO: Necessário montar comunicação com API de pagamentos e tratar retornos pras situações
  def confirm_payment
    self.status = set_status
    save
    true
  end

  # Método temporário pra mockar nos testes
  def set_status
    :approved
  end
end
