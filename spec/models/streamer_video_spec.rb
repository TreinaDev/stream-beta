require 'rails_helper'

RSpec.describe StreamerVideo, type: :model do
  describe 'associations' do
    it { should belong_to(:streamer) }
    it { should belong_to(:video) }
  end
end
