class VideoCategoriesController < ApplicationController
  before_action :authenticate_user!, only: :show
  before_action :authenticate_admin!, only: %i[create new]

  def new
    @video_category = VideoCategory.new
  end

  def create
    @video_category = VideoCategory.new(params.require(:video_category).permit(:title, :parent_id))
    if @video_category.save
      redirect_to @video_category, success: 'Categoria de Vídeo criada com sucesso!'
    else
      render :new
    end
  end

  def show
    @video_category = VideoCategory.find(params[:id])
    @video_category_parent = @video_category.parent
  end
end
