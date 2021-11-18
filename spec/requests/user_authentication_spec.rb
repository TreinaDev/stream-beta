require 'rails_helper'

describe 'User authentication' do
  context 'video category' do
    it 'cannot register video categories without login' do
      post '/video_categories'

      expect(response).to redirect_to(new_user_session_path)
    end

    it 'cannot view new video categories without login' do
      get '/video_categories/new'

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'streamers' do
    it 'cannot register streamers without login' do
      post '/streamers'

      expect(response).to redirect_to(new_user_session_path)
    end

    it 'cannot view new streamers without login' do
      get '/streamers/new'

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'subscription plan values' do
    it 'cannot register subscription plan values without login' do
      post '/subscription_plans/1/subscription_plan_values'

      expect(response).to redirect_to(new_user_session_path)
    end

    it 'cannot view new subscription plan values without login' do
      get '/subscription_plans/1/subscription_plan_values/new'

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'subscription plans' do
    it 'cannot register subscription plan values without login' do
      post '/subscription_plans'

      expect(response).to redirect_to(new_user_session_path)
    end

    it 'cannot view new subscription plan values without login' do
      get '/subscription_plans/new'

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'user subscription plans' do
    it 'cannot register user subscription plan values without login' do
      post '/user_subscription_plans'

      expect(response).to redirect_to(new_user_session_path)
    end

    it 'cannot view new user subscription plan values without login' do
      get '/user_subscription_plans/new'

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'user profiles' do
    it 'cannot register subscription plan values without login' do
      post '/subscription_plans'

      expect(response).to redirect_to(new_user_session_path)
    end

    it 'cannot view new subscription plan values without login' do
      get '/subscription_plans/new'

      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
