class VideoHistoriesController < ApplicationController
  def create
    video = Video.find(params[:video_id])
    VideoHistory.create(video: video, user: current_user)
    redirect_to video_path(video)
  end
end
