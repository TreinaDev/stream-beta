class CreateUserVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :user_videos do |t|
      t.references :user, null: false, foreign_key: true
      t.references :video, null: false, foreign_key: true
      t.string :product_token
      t.string :payment_method_token
      t.integer :status, default: 10, null: false
      t.datetime :status_date

      t.timestamps
    end

    add_index :user_videos, %i[user_id video_id], unique: true
  end
end
