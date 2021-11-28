class AddPromotionTicketRefToSubscriptionPlans < ActiveRecord::Migration[6.1]
  def change
    add_reference :subscription_plans, :promotion_ticket, foreign_key: true
  end
end

