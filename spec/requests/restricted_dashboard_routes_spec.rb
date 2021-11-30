require 'rails_helper'

describe 'Restricted dashboard routes' do
  context 'no user connection' do
    it "cannot access the 'dashboard' action" do
      get '/user/dashboard'

      expect(response).to redirect_to(new_user_session_path)
    end

    it "cannot access the 'my subscription plans' action" do
      get '/user/my_subscription_plans'

      expect(response).to redirect_to(new_user_session_path)
    end

    it "cannot access the 'my videos' action" do
      get '/user/my_videos'

      expect(response).to redirect_to(new_user_session_path)
    end

    it "cannot access the 'purchase history' action" do
      get '/user/purchase_history'

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'user admin connection' do
    it "cannot access the 'dashboard' action" do
      admin = create(:user, :admin)

      login_as admin, scope: :user
      get '/user/dashboard'

      expect(response).to redirect_to(admin_home_index_path)
    end

    it "cannot access the 'my subscription plans' action" do
      admin = create(:user, :admin)

      login_as admin, scope: :user
      get '/user/my_subscription_plans'

      expect(response).to redirect_to(admin_home_index_path)
    end

    it "cannot access the 'my videos' action" do
      admin = create(:user, :admin)

      login_as admin, scope: :user
      get '/user/my_videos'

      expect(response).to redirect_to(admin_home_index_path)
    end

    it "cannot access the 'purchase history' action" do
      admin = create(:user, :admin)

      login_as admin, scope: :user
      get '/user/purchase_history'

      expect(response).to redirect_to(admin_home_index_path)
    end
  end
end
