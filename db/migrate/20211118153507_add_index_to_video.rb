class AddIndexToVideo < ActiveRecord::Migration[6.1]
  def change
    add_index :videos, :title, unique: true
  end
end
