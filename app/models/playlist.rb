class Playlist < ApplicationRecord
  has_many :playlist_streamers
  has_many :streamers, through: :playlist_streamers

  has_many :original_relations, class_name: 'RelatedPlaylist', foreign_key: :original_playlist_id,
                                inverse_of: :original_playlist
  has_many :related_playlists, through: :original_relations, inverse_of: :original_playlists

  has_many :related_relations, class_name: 'RelatedPlaylist', foreign_key: :related_playlist_id,
                               inverse_of: :related_playlist
  has_many :original_playlists, through: :related_relations, inverse_of: :related_playlists

  has_one_attached :playlist_cover
end
