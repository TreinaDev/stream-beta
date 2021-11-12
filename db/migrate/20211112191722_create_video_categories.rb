class CreateVideoCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :video_categories do |t|
      t.string :title

      t.timestamps
    end
  end
end
