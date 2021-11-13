require 'rails_helper'

RSpec.describe Streamer, type: :model do
  context 'associations' do
    it { should have_one_attached(:avatar) }
  end

  context 'presence' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:avatar) }
  end

  context 'uniqueness' do
    it { should validate_uniqueness_of(:name) }
    it { should validate_uniqueness_of(:facebook_url) }
    it { should validate_uniqueness_of(:youtube_url) }
    it { should validate_uniqueness_of(:instagram_handle) }
    it { should validate_uniqueness_of(:twitter_handle) }
  end
end
