class Streamer < ApplicationRecord
  has_many :playlist_streamers, dependent: :destroy
  has_many :playlists, through: :playlist_streamers

  has_one_attached :avatar

  validates :name, :avatar, presence: true
  validates :name, :facebook_url, :youtube_url, :instagram_handle, :twitter_handle,
            uniqueness: { case_sensitive: false }
end
