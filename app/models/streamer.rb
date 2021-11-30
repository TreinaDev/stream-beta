class Streamer < ApplicationRecord
  has_many :playlist_streamers, dependent: :destroy
  has_many :playlists, through: :playlist_streamers

  has_many :subscription_plan_streamers, dependent: :destroy
  has_many :subscription_plans, through: :subscription_plan_streamers
  has_many :users, through: :subscription_plans

  has_many :videos, dependent: :restrict_with_error

  has_one_attached :avatar

  enum status: { active: 0, inactive: 10 }

  validates :name, :avatar, presence: true
  validates :name, :facebook_url, :youtube_url, :instagram_handle, :twitter_handle,
            uniqueness: { case_sensitive: false }
end
