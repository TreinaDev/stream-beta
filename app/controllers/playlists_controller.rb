class PlaylistsController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create edit update inactive]
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
      redirect_to @playlist, success: t('.success')
    else
      render :new
    end
  end

  def edit
    @playlist = Playlist.find(params[:id])
  end

  def update
    @playlist = Playlist.find(params[:id])

    if @playlist.update(playlist_params)
      redirect_to @playlist
    end
  end

  def inactive
    @playlist = Playlist.find(params[:id])
    @playlist.inactive!

    redirect_to @playlist, success: t('.success')
  end

  private

  def playlist_params
    params.require(:playlist).permit(:title, :description, :playlist_cover, streamer_ids: [])
  end
end
