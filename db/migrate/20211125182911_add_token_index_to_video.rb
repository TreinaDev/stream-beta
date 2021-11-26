class AddTokenIndexToVideo < ActiveRecord::Migration[6.1]
  def change
    add_index :videos, :token, unique: true
  end
end
