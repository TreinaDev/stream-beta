class UserSubscriptionPlan < ApplicationRecord
  belongs_to :user
  belongs_to :subscription_plan

  enum status: { pending: 10, approved: 50, rejected: 90 }

  # TODO: Necessário montar comunicação com API de pagamentos
  def confirm_payment
    true
  end
end
