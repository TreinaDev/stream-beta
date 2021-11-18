class AddIndexesToStreamer < ActiveRecord::Migration[6.1]
  def change
    add_index :streamers, :name, unique: true
    add_index :streamers, :facebook_url, unique: true
    add_index :streamers, :youtube_url, unique: true
    add_index :streamers, :instagram_handle, unique: true
    add_index :streamers, :twitter_handle, unique: true
  end
end
