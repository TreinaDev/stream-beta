class AddIndexesToSubscriptionPlanValue < ActiveRecord::Migration[6.1]
  def change
    add_index :subscription_plan_values,
              %i[subscription_plan_id start_date], unique: true, name: 'by_plan_and_start_date'
    add_index :subscription_plan_values,
              %i[subscription_plan_id end_date], unique: true, name: 'by_plan_and_end_date'
  end
end
