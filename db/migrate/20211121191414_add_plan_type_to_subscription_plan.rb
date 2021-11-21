class AddPlanTypeToSubscriptionPlan < ActiveRecord::Migration[6.1]
  def change
    add_column :subscription_plans, :plan_type, :integer, default: 10, null: false
  end
end
