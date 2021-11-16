class CreateSubscriptionPlans < ActiveRecord::Migration[6.1]
  def change
    create_table :subscription_plans do |t|
      t.string :title
      t.string :description
      t.decimal :value

      t.timestamps
    end
  end
end
