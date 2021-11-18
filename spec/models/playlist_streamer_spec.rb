require 'rails_helper'

RSpec.describe PlaylistStreamer, type: :model do
  describe 'associations' do
    it { should belong_to(:playlist) }
    it { should belong_to(:streamer) }
  end
end
