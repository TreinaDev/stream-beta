class AddIndexTitleToPromotionTicket < ActiveRecord::Migration[6.1]
  def change
    add_index :promotion_tickets, :title, unique: true
  end
end
