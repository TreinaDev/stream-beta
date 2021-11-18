require 'rails_helper'

RSpec.describe PlaylistVideo, type: :model do
  describe 'associations' do
    it { should belong_to(:playlist) }
    it { should belong_to(:video) }
  end
end
