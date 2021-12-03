class AddEnrollmentToUserSubscriptionPlan < ActiveRecord::Migration[6.1]
  def change
    add_column :user_subscription_plans, :enrollment, :integer, default: 100
  end
end