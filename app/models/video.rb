class Video < ApplicationRecord
  validates :title, :duration, :video_url, :maturity_rating, presence: true
  validates :duration, format: { with: /\d{2}:[0-5]\d:[0-5]\d/, message: 'não está formatada corretamente' }
  validates :video_url,
            format: {
              with: %r{(?:http|https)?(?:://)?(?:player\.)?vimeo\.com/(?:.*/)?\d{9}},
              message: 'não está formatada corretamente'
            }

  def obtain_video_info_from_vimeo
    source = "https://vimeo.com/api/oembed.json?url=#{video_url}"
    response = Net::HTTP.get_response(URI.parse(source))

    return false unless response.message == 'OK'

    JSON.parse(response.body, symbolize_names: true)
  end
end
