class SubscriptionPlanPromotionTickets < ApplicationRecord
  belongs_to :subscription_plan
  belongs_to :promotion_ticket
end
