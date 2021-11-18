class Video < ApplicationRecord
  has_many :playlist_videos, dependent: :destroy
  has_many :playlists, through: :playlist_videos

  has_one :streamer_video, dependent: :destroy
  has_one :streamer, through: :streamer_video

  validates :title, :duration, :video_url, :maturity_rating, presence: true
  validates :duration, format: { with: /\d{2}:[0-5]\d:[0-5]\d/, message: 'não está formatada corretamente' }
  validates :video_url,
            format: {
              with: %r{(?:http|https)?(?:://)?(?:player\.)?vimeo\.com/(?:.*/)?\d{9}},
              message: 'não está formatada corretamente'
            }
end
