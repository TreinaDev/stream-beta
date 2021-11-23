class CreateSubscriptionPlanStreamers < ActiveRecord::Migration[6.1]
  def change
    create_table :subscription_plan_streamers do |t|
      t.references :subscription_plan, null: false, foreign_key: true
      t.references :streamer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
