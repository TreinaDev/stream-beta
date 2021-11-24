class AddPaymentTypeToPaymentMethod < ActiveRecord::Migration[6.1]
  def change
    add_column :payment_methods, :payment_type, :integer, default: 10, null: false
  end

  add_index :payment_methods, %i[user_id payment_type], unique: true
end
