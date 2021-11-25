class User
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :user_must_fill_profile
    before_action :deny_admin_access

    def dashboard; end

    def purchase_history
      @subscription_plans = current_user.subscription_plans
      # TODO: Alterar quando o PR #67 for liberado
      # @videos = current_user.videos
      @videos = nil
    end

    def my_subscription_plans
      @subscription_plans = current_user.subscription_plans
    end

    def my_videos
      # TODO: Alterar quando o PR #67 for liberado
      # @videos = current_user.videos
    end
  end
end
