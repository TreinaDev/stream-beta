class VideoCategoriesController < ApplicationController
  before_action :authenticate_user!, only: :show
  before_action :authenticate_admin!, only: %i[create new]
  before_action :user_must_fill_profile

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

  private

  def video_category_params
    params.require(:video_category).permit(:title, :parent_id)
  end
end
