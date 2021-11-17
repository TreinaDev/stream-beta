class SubscriptionPlanValue < ApplicationRecord
  belongs_to :subscription_plan

  enum status: { active: 10, canceled: 90 }

  default_scope { active.order(start_date: :asc) }
  scope :filter_by_date, ->(date) { where('? BETWEEN start_date AND end_date', date) }

  validates :start_date, :end_date, :value, presence: true
  validates :start_date, :end_date, uniqueness: { scope: :subscription_plan_id }
  validates :value, numericality: { greater_than: 0 }

  validate :dates_cannot_overlap
  validate :end_date_cannot_come_before_start_date
  validate :cannot_start_before_current_date

  private

  def date_overlapping?(date)
    SubscriptionPlanValue.where('? BETWEEN start_date AND end_date', date).where.not(id: id).any?
  end

  def dates_cannot_overlap
    return unless start_date && end_date

    errors.add(:start_date, 'corresponde a um período já cadastrado') if date_overlapping?(start_date)
    errors.add(:end_date, 'corresponde a um período já cadastrado') if date_overlapping?(end_date)
  end

  def end_date_cannot_come_before_start_date
    return unless start_date && end_date

    errors.add(:end_date, 'deve ser maior ou igual a data inicial') if end_date < start_date
  end

  def cannot_start_before_current_date
    errors.add(:start_date, 'deve ser maior ou igual a data atual') if start_date && start_date < Date.current
  end
end
