class AddStatusToSubscriptionPlan < ActiveRecord::Migration[6.1]
  def change
    add_column :subscription_plans, :status, :integer, default: 15
  end
end
