require_relative '20211118001716_create_streamer_videos'

class UndoCreateStreamerVideos < ActiveRecord::Migration[6.1]
  def change
    revert CreateStreamerVideos
  end
end
