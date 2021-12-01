require_relative '20211128125811_create_subscription_plan_promotion_tickets'

class UndoCreateSubscriptionPlanPromotionTickets < ActiveRecord::Migration[6.1]
  def change
    revert CreateSubscriptionPlanPromotionTickets
  end
end
