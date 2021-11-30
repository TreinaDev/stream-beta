module Admin
  class ReportController < ApplicationController
    def report
      streamers = Streamer.all
      @streamers = streamers.zip streamers.map(&:users).map(&:count)
      @streamers.sort_by!(&:last).reverse!
      playlists = Playlist.all
      @playlists = playlists.zip playlists.map(&:users).map(&:count)
      @playlists.sort_by!(&:last).reverse!
    end
  end
end
