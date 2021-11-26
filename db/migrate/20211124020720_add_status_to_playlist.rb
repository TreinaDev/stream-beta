class AddStatusToPlaylist < ActiveRecord::Migration[6.1]
  def change
    add_column :playlists, :status, :integer, default: 5
  end
end
