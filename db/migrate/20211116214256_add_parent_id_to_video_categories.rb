class AddParentIdToVideoCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :video_categories, :parent_id, :integer, null: true, index: true
    add_foreign_key :video_categories, :video_categories, column: :parent_id
  end
end
