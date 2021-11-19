class AddIndexToVideoCategory < ActiveRecord::Migration[6.1]
  def change
    add_index :video_categories, :title, unique: true
  end
end
