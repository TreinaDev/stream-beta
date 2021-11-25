class AddVideoCategoryToPlaylist < ActiveRecord::Migration[6.1]
  def change
    add_reference :playlists, :video_category, null: false, foreign_key: true
  end
end
