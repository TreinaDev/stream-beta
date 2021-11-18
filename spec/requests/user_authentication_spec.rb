require 'rails_helper'

describe 'User authentication' do
  context 'video category' do
    it 'cannot registers video categories without login' do
      post '/video_categories'

      expect(response).to redirect_to(new_user_session_path)
    end

    it 'cannot view new video categories without login' do
      get '/video_categories/new'

      expect(response).to redirect_to(new_user_session_path)
    end
  end
  context 'streamers' do
    it 'cannot registers streamers without login' do
      post '/streamers'

      expect(response).to redirect_to(new_user_session_path)
    end

    it 'cannot view new streamers without login' do
      get '/streamers/new'

      expect(response).to redirect_to(new_user_session_path)
    end
  end
  context 'streamers' do
    it 'cannot registers streamers without login' do
      post '/streamers'

      expect(response).to redirect_to(new_user_session_path)
    end

    it 'cannot view new streamers without login' do
      get '/streamers/new'

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'subscription plan values' do
    it 'cannot registers subsciption plan values without login' do
      post '/subscription_plans/1/subscription_plan_values'

      expect(response).to redirect_to(new_user_session_path)
    end

    it 'cannot view new subsciption plan values without login' do
      get '/subscription_plans/1/subscription_plan_values/new'

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'subscription plans' do
    it 'cannot registers subsciption plan values without login' do
      post '/subscription_plans'

      expect(response).to redirect_to(new_user_session_path)
    end

    it 'cannot view new subsciption plan values without login' do
      get '/subscription_plans/new'

      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
