require 'rails_helper'

RSpec.describe VideoHistory, type: :model do
  describe 'uniqueness' do
    it 'fail in create a duplicate video history' do
      video = create(:video)
      user = create(:user)
      VideoHistory.create!(video: video, user: user)
      invalid = VideoHistory.new(video: video, user: user)
      expect(invalid.valid?).to eq false
    end
    it 'can create 2 video history with 2 videos and 1 user' do
      video1 = create(:video)
      video2 = create(:video)
      user = create(:user)
      VideoHistory.create!(video: video1, user: user)
      valid = VideoHistory.new(video: video2, user: user)
      expect(valid.valid?).to eq true
    end
    it 'can create 2 video history with 1 videos and 2 user' do
      video = create(:video)
      user1 = create(:user)
      user2 = create(:user)
      VideoHistory.create!(video: video, user: user1)
      valid = VideoHistory.new(video: video, user: user2)
      expect(valid.valid?).to eq true
    end
  end
end
