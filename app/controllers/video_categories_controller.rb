class VideoCategoriesController < ApplicationController
  def new
    @video_category = VideoCategory.new
  end

  def create
    @video_category = VideoCategory.new(params.require(:video_category).permit(:title, :parent_id))
    if @video_category.save
      flash[:notice] = 'Categoria de Vídeo criada com sucesso!'
      redirect_to @video_category
    else
      render action: 'new'
    end
  end

  def show
    @video_category = VideoCategory.find(params[:id])
  end
end
