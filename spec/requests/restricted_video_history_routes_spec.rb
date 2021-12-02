require 'rails_helper'

describe 'Restricted Video routes' do
  context 'when logged in as an admin' do
    before :context do
      @user = create(:user, :admin)
    end

    it "can't access the 'create' action" do
      video = create(:video)
      login_as @user, scope: :user
      post video_video_histories_path(video)

      expect(response).to redirect_to(admin_home_index_path)
    end
    it "can't access the 'destroy' action" do
      video = create(:video)
      video_whatched = create(:video_history, video: video)
      login_as @user, scope: :user
      delete video_video_history_path(video, video_whatched)

      expect(response).to redirect_to(admin_home_index_path)
    end
  end
  context 'when unauthenticated' do
    it "can't access the 'create' action" do
      video = create(:video)
      post video_video_histories_path(video)

      expect(response).to redirect_to(new_user_session_path)
    end

    it "can't access the 'destroy' action" do
      video = create(:video)
      video_whatched = VideoHistory.create!(video: video, user: create(:user))
      delete video_video_history_path(video, video_whatched)

      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
