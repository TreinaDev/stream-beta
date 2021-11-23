require 'rails_helper'

describe 'Restricted playlist routes' do
  context 'when logged in as an user' do
    before :context do
      @user = create(:user)
    end

    it "can't access the 'create' action" do
      login_as @user, scope: :user
      post playlists_path

      expect(response).to redirect_to(root_path)
    end

    it "can't access the 'new' action" do
      login_as @user, scope: :user
      get new_playlist_path

      expect(response).to redirect_to(root_path)
    end
  end

  context 'when unauthenticated' do
    it "can't access the 'create' action" do
      post playlists_path

      expect(response).to redirect_to(new_user_session_path)
    end

    it "can't access the 'new' action" do
      get new_playlist_path

      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
