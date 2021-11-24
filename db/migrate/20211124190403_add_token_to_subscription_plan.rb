class AddTokenToSubscriptionPlan < ActiveRecord::Migration[6.1]
  def change
    add_column :subscription_plans, :token, :string, null: false
  end
  add_index :subscription_plans, :token, unique: true
end
