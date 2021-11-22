class CreateSubscriptionPlanPlaylists < ActiveRecord::Migration[6.1]
  def change
    create_table :subscription_plan_playlists do |t|
      t.references :subscription_plan, null: false, foreign_key: true
      t.references :playlist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
