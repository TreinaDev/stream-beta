class StreamersController < ApplicationController
  def index
    @streamers = Streamer.all
  end

  def show
    @streamer = Streamer.find(params[:id])
  end

  def new
    @streamer = Streamer.new
  end

  def create
    @streamer = Streamer.new(streamer_params)

    if @streamer.save
      redirect_to streamer_path(@streamer), success: 'Cadastro realizado com sucesso!'
    else
      render :new
    end
  end

  def edit
    @streamer = Streamer.find(params[:id])
  end

  def update
    @streamer = Streamer.find(params[:id])

    if @streamer.update streamer_params
      redirect_to streamer_path(@streamer), success: 'Cadastro atualizado com sucesso!'
    else
      render :edit
    end
  end

  private

  def streamer_params
    params.require(:streamer).permit(:name, :avatar, :facebook_url,
                                     :youtube_url, :instagram_handle, :twitter_handle)
  end
end
