class ChangeVideoIndex < ActiveRecord::Migration[6.1]
  def change
    remove_index :videos, :title

    add_index :videos, %i[streamer_id title], unique: true
  end
end
