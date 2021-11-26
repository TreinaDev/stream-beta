class UserVideosController < ApplicationController
  before_action :authenticate_user!
  before_action :user_must_fill_profile
  before_action :deny_admin_access
  before_action :set_video

  def new
    @user_video = UserVideo.new
  end

  def create
    @user_video = current_user.user_videos.new(user_video_params)

    return render :new unless @user_video.save

    @user_video.confirm_payment

    set_status_flash
    redirect_to @video
  end

  private

  def user_video_params
    params.require(:user_video).permit(:product_token, :payment_method_token, :video_id)
  end

  def set_video
    video_id = params[:video_id] || params[:user_video][:video_id]
    @video = Video.find(video_id)
  end

  def set_status_flash
    case @user_video.status
    when 'pending'
      flash[:notice] = t('.pending')
    when 'approved'
      flash[:success] = t('.approved')
    when 'rejected'
      flash[:alert] = t('.rejected')
    end
  end
end
