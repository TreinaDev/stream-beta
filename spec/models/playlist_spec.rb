require 'rails_helper'

RSpec.describe Playlist, type: :model do
  describe 'associations' do
    it { should have_many(:playlist_streamers).dependent(:destroy) }
    it { should have_many(:streamers).through(:playlist_streamers) }

    it { should have_many(:playlist_videos).dependent(:destroy) }
    it { should have_many(:videos).through(:playlist_videos) }

    it do
      should have_many(:original_relations)
        .with_foreign_key(:original_playlist_id).inverse_of(:original_playlist).dependent(:destroy)
    end
    it { should have_many(:related_playlists).through(:original_relations).inverse_of(:original_playlists) }

    it do
      should have_many(:related_relations)
        .with_foreign_key(:related_playlist_id).inverse_of(:related_playlist).dependent(:destroy)
    end
    it { should have_many(:original_playlists).through(:related_relations).inverse_of(:related_playlists) }

    it { should have_one_attached(:playlist_cover) }
  end

  describe 'presence' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:playlist_cover) }
  end
end
