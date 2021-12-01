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

  def edit
    @playlist = Playlist.find(params[:id])
  end

  def update
    @playlist = Playlist.find(params[:id])

    redirect_to @playlist if @playlist.update(playlist_params)
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

  def inactive
    @playlist = Playlist.find(params[:id])
    @playlist.inactive!

    redirect_to @playlist, success: t('.success')
  end

  def search
    @playlists = Playlist.where('title like ? OR description like ?',
                                "%#{params[:query]}%", "%#{params[:query]}%").reject(&:inactive?)
    with_streamers = Playlist.joins(:streamers).where('name like ?', "%#{params[:query]}%").reject(&:inactive?)
    @playlists.concat(with_streamers).uniq!
    render :index
  end

  private

  def playlist_params
    params.require(:playlist).permit(:title, :description, :playlist_cover, streamer_ids: [], video_ids: [])
  end
end
