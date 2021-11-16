class SubscriptionPlan < ApplicationRecord
  has_many :subscription_plan_values, dependent: :destroy

  validates :title, :description, :value, presence: true
  validates :title, uniqueness: { case_sensitive: false }
  validates :value, numericality: { greater_than: 0 }

  def current_value
    SubscriptionPlanValue.active.where('? BETWEEN start_date AND end_date', Date.current).pluck(:value).first || value
  end
end
