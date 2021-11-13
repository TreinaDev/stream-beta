class Streamer < ApplicationRecord
  has_one_attached :avatar

  validates :name, :avatar, presence: true
  validates :name, :facebook_url, :youtube_url, :instagram_handle, :twitter_handle, uniqueness: true
end
