require 'rails_helper'

RSpec.describe Streamer, type: :model do
  describe 'associations' do
    it { should have_many(:playlist_streamers).dependent(:destroy) }
    it { should have_many(:playlists).through(:playlist_streamers) }

    it { should have_many(:subscription_plan_streamers).dependent(:destroy) }
    it { should have_many(:subscription_plans).through(:subscription_plan_streamers) }

    it { should have_many(:videos).dependent(:restrict_with_error) }

    it { should have_one_attached(:avatar) }
  end

  describe 'enum' do
    it { should define_enum_for(:status).with_values(active: 0, inactive: 10) }
  end

  describe 'presence' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:avatar) }
  end

  describe 'uniqueness' do
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should validate_uniqueness_of(:facebook_url).case_insensitive }
    it { should validate_uniqueness_of(:youtube_url).case_insensitive }
    it { should validate_uniqueness_of(:instagram_handle).case_insensitive }
    it { should validate_uniqueness_of(:twitter_handle).case_insensitive }
  end
end
