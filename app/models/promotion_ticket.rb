class PromotionTicket < ApplicationRecord
  has_many :subscription_plans, through: :subscription_plan_promotion_ticket

  validates :title, :discount, :maximum_value_reduction,
            :maximum_uses, :start_date, :end_date, presence: true

  validates :title, uniqueness: true
  validates :discount, :maximum_value_reduction,
            numericality: { greater_than: 0 }

  validates :maximum_uses, numericality: { greater_than: 0 }, on: :create

  validate :end_date_cannot_come_before_start_date
  validate :cannot_start_before_current_date

  def using_promotion_ticket(promotion_ticket)
    errors.add(:maximum_uses, 'Ticket de promoção esgotado!') if promotion_ticket.maximum_uses.zero?
    promotion_ticket.update!(maximum_uses: promotion_ticket.maximum_uses - 1)
  end

  # def test_maximum_uses_zero                                   em progresso
  #   test_if_maximum_uses_is_greater_than_zero
  # end

  private

  # def test_if_maximum_uses_zero                              em progresso
  #   errors.add(:maximum_uses, 'Ticket de promoção esgotado!') if @subscription_plan.promotion_ticket.maximum_uses.zero?
  # end

  def end_date_cannot_come_before_start_date
    return unless start_date && end_date

    errors.add(:end_date, 'deve ser maior ou igual a data inicial') if end_date < start_date
  end

  def cannot_start_before_current_date
    errors.add(:start_date, 'deve ser maior ou igual a data atual') if start_date && start_date < Date.current
  end
end
