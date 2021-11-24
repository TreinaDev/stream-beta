class AddTokenIndexToPaymentMethod < ActiveRecord::Migration[6.1]
  def change
    add_index :payment_methods, :token, unique: true
  end
end
