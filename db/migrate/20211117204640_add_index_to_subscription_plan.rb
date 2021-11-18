class AddIndexToSubscriptionPlan < ActiveRecord::Migration[6.1]
  def change
    add_index :subscription_plans, :title, unique: true
  end
end
