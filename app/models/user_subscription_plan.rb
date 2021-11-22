class UserSubscriptionPlan < ApplicationRecord
  belongs_to :user
  belongs_to :subscription_plan

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
