class CreateSubscriptionPlanValues < ActiveRecord::Migration[6.1]
  def change
    create_table :subscription_plan_values do |t|
      t.date :start_date
      t.date :end_date
      t.decimal :value
      t.references :subscription_plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
