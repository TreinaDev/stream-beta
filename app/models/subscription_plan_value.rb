class SubscriptionPlanValue < ApplicationRecord
  belongs_to :subscription_plan

  validates :start_date, :end_date, :value, presence: true
  validates :start_date, :end_date, uniqueness: { scope: :subscription_plan_id }
  validates :value, numericality: { greater_than: 0 }
end
