require 'rails_helper'

describe 'Restricted Video routes' do
  context 'when logged in as an user' do
    before :context do
      @user = create(:user)
    end

    it "can't access the 'create' action" do
      login_as @user, scope: :user
      post videos_path

      expect(response).to redirect_to(root_path)
    end

    it "can't access the 'update' action" do
      video = create(:video)
      login_as @user, scope: :user
      patch video_path(video)

      expect(response).to redirect_to(root_path)
    end

    it "can't access the 'new' action" do
      login_as @user, scope: :user
      get new_video_path

      expect(response).to redirect_to(root_path)
    end
  end

  context 'when unauthenticated' do
    it "can't access the 'create' action" do
      post videos_path

      expect(response).to redirect_to(new_user_session_path)
    end

    it "can't access the 'new' action" do
      get new_video_path

      expect(response).to redirect_to(new_user_session_path)
    end

    it "can't access the 'update' action" do
      video = create(:video)
      patch video_path(video)

      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
