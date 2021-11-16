class SubscriptionPlanValue < ApplicationRecord
  belongs_to :subscription_plan

  enum status: { active: 10, canceled: 90 }

  validates :start_date, :end_date, :value, presence: true
  validates :start_date, :end_date, uniqueness: { scope: :subscription_plan_id }
  validates :value, numericality: { greater_than: 0 }

  validate :dates_cannot_overlap

  private

  def dates_cannot_overlap
    if SubscriptionPlanValue.active.where('? BETWEEN start_date AND end_date', start_date).any?
      errors.add(:start_date, 'corresponde a um período já cadastrado')
    end

    if SubscriptionPlanValue.active.where('? BETWEEN start_date AND end_date', end_date).any?
      errors.add(:end_date, 'corresponde a um período já cadastrado')
    end
  end
end
