class Video < ApplicationRecord
  has_many :playlist_videos, dependent: :destroy
  has_many :playlists, through: :playlist_videos

  belongs_to :streamer

  validates :title, :duration, :video_url, :maturity_rating, presence: true
  validates :title, uniqueness: { scope: :streamer_id }
  validates :duration, format: { with: /\d{2}:[0-5]\d:[0-5]\d/, message: 'não está formatada corretamente' }
  validates :video_url,
            format: {
              with: %r{(?:http|https)?(?:://)?(?:player\.)?vimeo\.com/(?:.*/)?\d{9}},
              message: 'não está formatada corretamente'
            }

  enum status: { active: 0, inactive: 10 }
end
