class UserSubscriptionPlan < ApplicationRecord
  belongs_to :user
  belongs_to :subscription_plan

  # TODO: Necessário comunicação com API de pagamentos
  # Idéia: Utilizar o método 'validate_payment' para obter autorização da plataforma de pagamentos
  def validate_payment
    true
  end

  # TODO: Necessário comunicação com API de pagamentos
  # Idéia: Utilizar o método 'confirm_payment' para notificar o sistema de pagamentos que a cobrança pode ser efetuada
  def confirm_payment
    true
  end
end
