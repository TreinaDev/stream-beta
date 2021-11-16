class AddStatusToSubscriptionPlanValue < ActiveRecord::Migration[6.1]
  def change
    add_column :subscription_plan_values, :status, :integer, default: 10
  end
end
