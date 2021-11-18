class VideosController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create]

  def index
    @videos = Video.all
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      redirect_to video_path(@video), success: 'Vídeo criado com sucesso!'
    else
      render :new
    end
  end

  def show
    @video = Video.find(params[:id])
  end

  private

  def video_params
    params.require(:video).permit(:title, :duration, :video_url, :maturity_rating)
  end
end
