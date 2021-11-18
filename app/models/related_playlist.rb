class RelatedPlaylist < ApplicationRecord
  belongs_to :original_playlist, class_name: 'Playlist', inverse_of: :original_relations
  belongs_to :related_playlist, class_name: 'Playlist', inverse_of: :related_relations
end
