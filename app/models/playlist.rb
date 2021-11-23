class Playlist < ApplicationRecord
  has_many :playlist_streamers, dependent: :destroy
  has_many :streamers, through: :playlist_streamers

  has_many :playlist_videos, dependent: :destroy
  has_many :videos, through: :playlist_videos

  has_many :original_relations, class_name: 'RelatedPlaylist', foreign_key: :original_playlist_id,
                                inverse_of: :original_playlist, dependent: :destroy
  has_many :related_playlists, through: :original_relations, inverse_of: :original_playlists

  has_many :related_relations, class_name: 'RelatedPlaylist', foreign_key: :related_playlist_id,
                               inverse_of: :related_playlist, dependent: :destroy
  has_many :original_playlists, through: :related_relations, inverse_of: :related_playlists

  has_many :subscription_plan_playlists, dependent: :destroy
  has_many :playlists, through: :subscription_plan_playlists

  has_one_attached :playlist_cover

  validates :title, :description, :playlist_cover, presence: true
end
