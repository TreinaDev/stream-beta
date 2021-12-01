class AddStatusToVideoCategory < ActiveRecord::Migration[6.1]
  def change
    add_column :video_categories, :status, :integer, default: 10
  end
end
