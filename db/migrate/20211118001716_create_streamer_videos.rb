class CreateStreamerVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :streamer_videos do |t|
      t.references :streamer, null: false, foreign_key: true
      t.references :video, null: false, foreign_key: true

      t.timestamps
    end
  end
end
