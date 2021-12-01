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
    @categories = VideoCategory.all.order(:title)
  end

  def update
    @playlist = Playlist.find(params[:id])

    if @playlist.update(playlist_params)
      redirect_to @playlist, success: t('.success')
    else
      render :edit
    end
  end

  def new
    @playlist = Playlist.new
    @categories = VideoCategory.all.order(:title)
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
    render :index
  end

  private

  def playlist_params
    params.require(:playlist).permit(:title, :description, :playlist_cover,
                                     streamer_ids: [], video_ids: [], video_category_ids: [])
  end
end
