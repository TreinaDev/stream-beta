require 'rails_helper'

describe 'Restricted SubscriptionPlanStreamer routes' do
  context 'when logged in as an user' do
    before :context do
      @user = create(:user)
    end

    it "can't access the 'create' action" do
      login_as @user, scope: :user
      post subscription_plan_subscription_plan_streamers_path(1)

      expect(response).to redirect_to(root_path)
    end

    it "can't access the 'new' action" do
      login_as @user, scope: :user
      get new_subscription_plan_subscription_plan_streamer_path(1)

      expect(response).to redirect_to(root_path)
    end

    it "can't access the 'edit' action" do
      login_as @user, scope: :user
      get edit_subscription_plan_streamer_path(1)

      expect(response).to redirect_to(root_path)
    end

    it "can't access the 'update' action" do
      login_as @user, scope: :user
      patch subscription_plan_streamer_path(1)

      expect(response).to redirect_to(root_path)
    end

    it "can't access the 'update' action" do
      login_as @user, scope: :user
      put subscription_plan_streamer_path(1)

      expect(response).to redirect_to(root_path)
    end
  end

  context 'when unauthenticated' do
    it "can't access the 'create' action" do
      post subscription_plan_subscription_plan_streamers_path(1)

      expect(response).to redirect_to(new_user_session_path)
    end

    it "can't access the 'new' action" do
      get new_subscription_plan_subscription_plan_streamer_path(1)

      expect(response).to redirect_to(new_user_session_path)
    end

    it "can't access the 'edit' action" do
      get edit_subscription_plan_streamer_path(1)

      expect(response).to redirect_to(new_user_session_path)
    end

    it "can't access the 'update' action" do
      patch subscription_plan_streamer_path(1)

      expect(response).to redirect_to(new_user_session_path)
    end

    it "can't access the 'update' action" do
      put subscription_plan_streamer_path(1)

      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
