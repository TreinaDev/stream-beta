class CreateProductReceipts < ActiveRecord::Migration[6.1]
  def change
    create_table :product_receipts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, polymorphic: true, null: false
      t.references :payment_method, null: false, foreign_key: true
      t.decimal :value
      t.string :receipt_token
      t.datetime :receipt_date

      t.timestamps
    end

    add_index :product_receipts, :receipt_token, unique: true
  end
end
