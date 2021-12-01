class CreateCategoryLists < ActiveRecord::Migration[6.1]
  def change
    create_table :category_lists do |t|
      t.references :video_category, null: false, foreign_key: true
      t.references :categoriable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
