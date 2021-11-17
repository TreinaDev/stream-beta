require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'presence' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:duration) }
    it { should validate_presence_of(:video_url) }
    it { should validate_presence_of(:maturity_rating) }
  end

  describe 'format' do
    it {
      should allow_values('vimeo.com/123456789').for(:video_url)
      should allow_values('http://vimeo.com/123456789').for(:video_url)
      should allow_values('https://vimeo.com/123456789').for(:video_url)

      should allow_values('player.vimeo.com/video/123456789').for(:video_url)
      should allow_values('http://player.vimeo.com/video/123456789').for(:video_url)
      should allow_values('https://player.vimeo.com/video/123456789').for(:video_url)

      should allow_values('vimeo.com/channels/mychannel/123456789').for(:video_url)
      should allow_values('http://vimeo.com/channels/mychannel/123456789').for(:video_url)
      should allow_values('https://vimeo.com/channels/mychannel/123456789').for(:video_url)

      should allow_values('vimeo.com/groups/shortfilms/videos/123456789').for(:video_url)
      should allow_values('http://vimeo.com/groups/shortfilms/videos/123456789').for(:video_url)
      should allow_values('https://vimeo.com/groups/shortfilms/videos/123456789').for(:video_url)
    }

    it { should_not allow_values('https://youtube.com').for(:video_url) }
  end
end
