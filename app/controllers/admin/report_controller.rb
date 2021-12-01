module Admin
  class ReportController < ApplicationController
    before_action :authenticate_admin!, only: :report
    def report
      streamers = Streamer.all
      @streamers = streamers.zip streamers.map(&:users).map(&:count)
      @streamers.sort_by!(&:last).reverse!
      playlists = Playlist.all
      @playlists = playlists.zip playlists.map(&:users).map(&:count)
      @playlists.sort_by!(&:last).reverse!
      videos = Video.select(&:allow_purchase?)
      @videos = videos.zip videos.map(&:users).map(&:count)
      @videos.sort_by!(&:last).reverse!
    end
  end
end
