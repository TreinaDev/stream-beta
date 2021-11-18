require 'rails_helper'

describe 'Admin authentication' do
  context 'video category' do
    it 'cannot registers video categories without admin' do
      user = create(:user)
      login_as user, scope: :user
      post '/video_categories'

      expect(response).to redirect_to(root_path)
    end

    it 'cannot view new video categories without admin' do
      user = create(:user)
      login_as user, scope: :user
      get '/video_categories/new'

      expect(response).to redirect_to(root_path)
    end
  end
  context 'streamers' do
    it 'cannot registers streamers without login' do
      user = create(:user)
      login_as user, scope: :user
      post '/streamers'

      expect(response).to redirect_to(root_path)
    end

    it 'cannot view new streamers without login' do
      user = create(:user)
      login_as user, scope: :user
      get '/streamers/new'
      expect(response).to redirect_to(root_path)
    end
  end

  context 'subscription plan values' do
    it 'cannot registers subscription plan values without login' do
      user = create(:user)
      login_as user, scope: :user
      post '/subscription_plans/1/subscription_plan_values'

      expect(response).to redirect_to(root_path)
    end

    it 'cannot view new subscription plan values without login' do
      user = create(:user)
      login_as user, scope: :user
      get '/subscription_plans/1/subscription_plan_values/new'
      expect(response).to redirect_to(root_path)
    end
  end

  context 'subscription plans' do
    it 'cannot registers subscription plan values without login' do
      user = create(:user)
      login_as user, scope: :user
      post '/subscription_plans'

      expect(response).to redirect_to(root_path)
    end

    it 'cannot view new subscription plan values without login' do
      user = create(:user)
      login_as user, scope: :user
      get '/subscription_plans/new'
      expect(response).to redirect_to(root_path)
    end
  end
end
