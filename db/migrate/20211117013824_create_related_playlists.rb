class CreateRelatedPlaylists < ActiveRecord::Migration[6.1]
  def change
    create_table :related_playlists do |t|
      t.integer :original_playlist_id, null: false
      t.integer :related_playlist_id, null: false

      t.timestamps
    end

    add_foreign_key :related_playlists, :playlists, column: :original_playlist_id
    add_foreign_key :related_playlists, :playlists, column: :related_playlist_id
  end
end
