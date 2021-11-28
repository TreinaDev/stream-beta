class PromotionTicket < ApplicationRecord
  has_many :subscription_plans, through: :subscription_plan_promotion_ticket
  
  validates :title, :discount, :maximum_value_reduction,
            :maximum_uses, :start_date, :end_date, presence: true

  validates :title, uniqueness: true
  validates :discount, :maximum_uses, :maximum_value_reduction,
            numericality: { greater_than: 0 }

  validate :end_date_cannot_come_before_start_date
  validate :cannot_start_before_current_date

  private

  def end_date_cannot_come_before_start_date
    return unless start_date && end_date

    errors.add(:end_date, 'deve ser maior ou igual a data inicial') if end_date < start_date
  end

  def cannot_start_before_current_date
    errors.add(:start_date, 'deve ser maior ou igual a data atual') if start_date && start_date < Date.current
  end
end
