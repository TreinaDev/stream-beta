class PlaylistsController < ApplicationController
  def index
    @playlists = Playlist.all
  end

  def show
    @playlist = Playlist.find(params[:id])
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

  private

  def playlist_params
    params.require(:playlist).permit(:title, :description, :playlist_cover)
  end
end
