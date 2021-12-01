class CreateSubscriptionPlanPromotionTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :subscription_plan_promotion_tickets do |t|
      t.references :subscription_plan, null: false, foreign_key: true,
                    index: {name: "index_subs_plan_promo_ticket_on_subs_plan_id"} 
      t.references :promotion_ticket, null: false, foreign_key: true,
                    index: {name: "index_subs_plan_promo_ticket_on_promo_ticket_id"} 
      
      t.timestamps
    end
  end
end
