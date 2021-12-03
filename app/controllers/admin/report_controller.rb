module Admin
  class ReportController < ApplicationController
    before_action :authenticate_admin!, only: :report
    def report
      @streamers = get_subscribers(Streamer.all)
      @playlists = get_subscribers(Playlist.all)
      @videos = get_subscribers(Video.select(&:allow_purchase?))
    end

    private

    def get_subscribers(array)
      array = array.zip array.map(&:users).map(&:count)
      array.sort_by!(&:last).reverse!
    end
  end
end
