class Video < ApplicationRecord
  has_many :playlist_videos, dependent: :destroy
  has_many :playlists, through: :playlist_videos

  has_many :user_videos, dependent: :destroy
  has_many :users, through: :user_videos

  belongs_to :streamer

  validates :title, :duration, :video_url, :maturity_rating, presence: true
  validates :title, uniqueness: { scope: :streamer_id }
  validates :duration, format: { with: /\d{2}:[0-5]\d:[0-5]\d/, message: 'não está formatada corretamente' }
  validates :video_url, format: {
    with: %r{(?:http|https)?(?:://)?(?:player\.)?vimeo\.com/(?:.*/)?\d{9}},
    message: 'não está formatada corretamente'
  }
  validates :allow_purchase, inclusion: [true, false]
  validates :value, numericality: { greater_than: 0 }, if: :allow_purchase?

  def request_token
    self.token = generate_new_token(title, value) if token.nil?
  end

  private

  def generate_new_token(title, value)
    token_params = { title: title, value: value }
    result = nil

    response = Faraday.post('http://localhost:4000/api/v1/videos/', token_params.to_json)

    if response.status == 201
      data = JSON.parse(response.body, symbolize_names: true)
      result = data[:video_token]
    end

    result
  end
end
