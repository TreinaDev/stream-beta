require 'rails_helper'

describe 'Restricted UserSubscriptionPlan routes' do
  context 'when unauthenticated' do
    it "can't access the 'create' action" do
      post user_subscription_plans_path

      expect(response).to redirect_to(new_user_session_path)
    end

    it "can't access the 'new' action" do
      get new_user_subscription_plan_path

      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
