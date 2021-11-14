class SubscriptionPlan < ApplicationRecord
  validates :title, uniqueness: true
  validates :title, :description, :value, presence: true
  validates :value, numericality: {greater_than: 0}
end
