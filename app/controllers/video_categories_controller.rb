class VideoCategoriesController < ApplicationController
  before_action :authenticate_user!, only: :show
  before_action :authenticate_admin!, only: %i[create new index show cancel]
  before_action :user_must_fill_profile

  def index
    @video_category = VideoCategory.all
  end

  def new
    @video_category = VideoCategory.new
  end

  def create
    @video_category = VideoCategory.new(video_category_params)

    if @video_category.save
      redirect_to @video_category, success: t('.success')
    else
      render :new
    end
  end

  def show
    @video_category = VideoCategory.find(params[:id])
  end

  def edit
    @video_category = VideoCategory.find(params[:id])
  end

  def update
    @video_category = VideoCategory.find(params[:id])

    redirect_to @video_category, success: t('.success') if @video_category.update(video_category_params)
  end

  def cancel
    @video_category = VideoCategory.find(params[:id])
    @video_category.canceled!

    redirect_to video_categories_path, success: t('.success')
  end

  private

  def video_category_params
    params.require(:video_category).permit(:title, :parent_id)
  end
end
