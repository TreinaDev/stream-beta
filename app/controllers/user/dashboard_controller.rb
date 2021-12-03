class User
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :user_must_fill_profile
    before_action :deny_admin_access

    def dashboard; end

    def purchase_history
      @subscription_plans = current_user.subscription_plans
      @videos = current_user.videos
    end

    def my_subscription_plans
      @subscription_plans = current_user.subscription_plans
      @my_subscription_plans = current_user.user_subscription_plans
    end

    def my_videos
      @videos = current_user.videos
    end
  end
end
