class AddFieldsToStreamer < ActiveRecord::Migration[6.1]
  def change
    add_column :streamers, :facebook_url, :string
    add_column :streamers, :youtube_url, :string
    add_column :streamers, :instagram_handle, :string
    add_column :streamers, :twitter_handle, :string
  end
end
