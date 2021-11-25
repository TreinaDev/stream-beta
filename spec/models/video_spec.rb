require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'associations' do
    it { should have_many(:playlist_videos).dependent(:destroy) }
    it { should have_many(:playlists).through(:playlist_videos) }

    it { should belong_to(:streamer) }
  end

  describe 'presence' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:duration) }
    it { should validate_presence_of(:video_url) }
    it { should validate_presence_of(:maturity_rating) }
  end

  describe 'uniqueness' do
    subject { build(:video) }

    it { should validate_uniqueness_of(:title).scoped_to(:streamer_id) }
  end

  describe 'enum' do
    it { should define_enum_for(:status).with_values(active: 0, inactive: 10) }
  end

  describe 'format' do
    it do
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
    end

    it { should_not allow_values('https://youtube.com').for(:video_url) }
  end
end
