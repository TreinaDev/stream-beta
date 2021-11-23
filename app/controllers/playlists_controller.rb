class PlaylistsController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create]
  before_action :user_must_fill_profile

  def index
    @playlists = Playlist.all
  end

  def show
    @playlist = Playlist.find(params[:id])
    @playlist_streamers = PlaylistStreamer.find_by(playlist: @playlist)
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new(playlist_params)

    if @playlist.save
      redirect_to new_playlist_playlist_streamer_path(@playlist), success: t('.success')
    else
      render :new
    end
  end

  private

  def playlist_params
    params.require(:playlist).permit(:title, :description, :playlist_cover, :streamers_id)
  end
end
