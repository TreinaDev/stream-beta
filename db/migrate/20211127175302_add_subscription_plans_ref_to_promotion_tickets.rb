class AddSubscriptionPlansRefToPromotionTickets < ActiveRecord::Migration[6.1]
  def change
    add_reference :promotion_tickets, :subscription_plan, foreign_key: true
  end
end

