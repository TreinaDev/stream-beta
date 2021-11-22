class AddFieldsToUserSubscriptionPlan < ActiveRecord::Migration[6.1]
  def change
    add_column :user_subscription_plans, :product_token, :string
    add_column :user_subscription_plans, :payment_method_token, :string
    add_column :user_subscription_plans, :status, :integer, default: 10, null: false
    add_column :user_subscription_plans, :status_date, :datetime
  end
end
