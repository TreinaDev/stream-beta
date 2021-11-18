class UserSubscriptionPlan < ApplicationRecord
  belongs_to :user
  belongs_to :subscription_plan

  def validate_payment
    # TODO: Necessário comunicação com API de pagamentos
    true
  end
end
