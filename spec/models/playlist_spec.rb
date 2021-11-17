require 'rails_helper'

RSpec.describe Playlist, type: :model do
  describe 'associations' do
    it { should have_many(:playlist_streamers) }
    it { should have_many(:streamers).through(:playlist_streamers) }

    it { should have_many(:original_relations).with_foreign_key(:original_playlist_id).inverse_of(:original_playlist) }
    it { should have_many(:related_playlists).through(:original_relations).inverse_of(:original_playlists) }

    it { should have_many(:related_relations).with_foreign_key(:related_playlist_id).inverse_of(:related_playlist) }
    it { should have_many(:original_playlists).through(:related_relations).inverse_of(:related_playlists) }

    it { should have_one_attached(:playlist_cover) }
  end
end
