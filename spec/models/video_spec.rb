require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'associations' do
    it { should have_many(:playlist_videos).dependent(:destroy) }
    it { should have_many(:playlists).through(:playlist_videos) }

    it { should have_many(:user_videos) }
    it { should have_many(:users).through(:user_videos) }

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

  describe 'inclusion' do
    it { should_not allow_value(nil).for(:allow_purchase) }
  end

  describe 'numericality' do
    context 'when allow_purchase is true' do
      subject { build(:video, allow_purchase: true) }

      it { should validate_numericality_of(:value).is_greater_than(0) }
    end

    context 'when allow_purchase is false' do
      subject { build(:video, allow_purchase: false) }

      it { should_not validate_numericality_of(:value) }
    end
  end

  describe '#generate_new_token' do
    let(:video) { JSON.parse(File.read(Rails.root.join('spec/support/apis/video.json'))) }

    subject do
      Video.new(video)
    end

    it 'successfully' do
      api_response = File.read(Rails.root.join('spec/support/apis/video_response.json'))
      stub_request(:post, 'http://localhost:4000/api/v1/videos/')
        .with(body: video.to_json).to_return(body: api_response, status: 201)

      subject.request_token
      expect(subject.token).to eq 'w3HlRYCy2r'
    end

    it 'and fails due to server error' do
      stub_request(:post, 'http://localhost:4000/api/v1/videos/')
        .with(body: video.to_json).to_return(status: 500)

      subject.request_token
      expect(subject.token).to eq nil
    end
  end
end
