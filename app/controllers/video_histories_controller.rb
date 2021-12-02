class VideoHistoriesController < ApplicationController
  def create
    video = Video.find(params[:video_id])
    VideoHistory.create(video: video, user: current_user)
    redirect_to video_path(video)
  end

  def destroy
    video = Video.find(params[:video_id])
    video_history = VideoHistory.find_by(video: video, user: current_user)
    video_history.destroy
    redirect_to video_path(video)
  end
end
