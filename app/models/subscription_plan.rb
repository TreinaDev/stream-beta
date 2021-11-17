class SubscriptionPlan < ApplicationRecord
  has_many :subscription_plan_values, dependent: :destroy

  validates :title, :description, :value, presence: true
  validates :title, uniqueness: { case_sensitive: false }
  validates :value, numericality: { greater_than: 0 }

  def current_value
    subscription_plan_values.filter_by_date(Date.current).pick(:value) || value
  end
end
