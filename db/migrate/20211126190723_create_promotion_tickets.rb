class CreatePromotionTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :promotion_tickets do |t|
      t.string :title
      t.date :start_date
      t.date :end_date
      t.integer :discount
      t.decimal :maximum_value_reduction
      t.integer :maximum_uses

      t.timestamps
    end
  end
end
