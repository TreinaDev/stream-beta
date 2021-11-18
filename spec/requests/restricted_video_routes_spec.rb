require 'rails_helper'

describe 'Restricted video routes' do
  context 'when logged in as an user' do
    it "cannot access the 'new' action" do
      user = create(:user)

      login_as user, scope: :user
      get new_video_path

      expect(response).to have_http_status(302)
    end

    it "cannot access the 'create' action" do
      user = create(:user)

      login_as user, scope: :user
      post videos_path

      expect(response).to have_http_status(302)
    end
  end
end
