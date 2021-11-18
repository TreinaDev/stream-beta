class CreateUserSubscriptionPlans < ActiveRecord::Migration[6.1]
  def change
    create_table :user_subscription_plans do |t|
      t.references :user, null: false, foreign_key: true
      t.references :subscription_plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
