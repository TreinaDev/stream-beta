require 'rails_helper'

describe 'User authentication' do
  context 'video category' do
    it 'cannot registers video categories without login' do
      post '/video_categories'

      expect(response).to redirect_to(new_user_session_path)
    end

    it 'cannot registers video categories without admin' do
      user = create(:user, admin: false)
      login_as user, scope: :user
      post '/video_categories'

      expect(response).to redirect_to(root_path)
    end

    it 'cannot view new video categories without login' do
      get '/video_categories/new'

      expect(response).to redirect_to(new_user_session_path)
    end

    it 'cannot view new video categories without admin' do
      user = create(:user, admin: false)
      login_as user, scope: :user
      get '/video_categories/new'

      expect(response).to redirect_to(root_path)
    end
  end
end
