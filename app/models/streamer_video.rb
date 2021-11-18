class StreamerVideo < ApplicationRecord
  belongs_to :streamer
  belongs_to :video
end
