class AddAllowPurchaseAndValueToVideo < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :allow_purchase, :boolean, default: false
    add_column :videos, :value, :decimal
    add_column :videos, :token, :string
  end
end
