class HomeController < ApplicationController
  def index
    @streamers = Streamer.all
  end
end
