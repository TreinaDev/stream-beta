require 'rails_helper'

describe 'Restricted user videos routes' do
  context 'no user connection' do
    it "cannot access the 'new' action" do
      get '/user_videos/new'

      expect(response).to redirect_to(new_user_session_path)
    end

    it "cannot access the 'create' action" do
      post '/user_videos'

      expect(response).to redirect_to(new_user_session_path)
    end
  end
  context 'user admin connection' do
    it "cannot access the 'new' action" do
      admin = create(:user, :admin)

      login_as admin, scope: :user
      get '/user_videos/new'

      expect(response).to redirect_to(admin_home_index_path)
    end

    it "cannot access the 'create' action" do
      admin = create(:user, :admin)

      login_as admin, scope: :user
      post '/user_videos'

      expect(response).to redirect_to(admin_home_index_path)
    end
  end
end
