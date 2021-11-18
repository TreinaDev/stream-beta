require 'rails_helper'

RSpec.describe RelatedPlaylist, type: :model do
  describe 'associations' do
    it { should belong_to(:original_playlist).inverse_of(:original_relations) }
    it { should belong_to(:related_playlist).inverse_of(:related_relations) }
  end
end
