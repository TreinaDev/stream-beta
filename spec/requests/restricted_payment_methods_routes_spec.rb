require 'rails_helper'

describe 'Restricted payment methods routes' do
  context 'no user connection' do
    it "cannot access the 'new' action" do
      get '/payment_methods/new'

      expect(response).to redirect_to(new_user_session_path)
    end

    it "cannot access the 'create' action" do
      post '/payment_methods'

      expect(response).to redirect_to(new_user_session_path)
    end

    it "cannot access the 'show' action" do
      get '/payment_methods/1'

      expect(response).to redirect_to(new_user_session_path)
    end
  end
  context 'user admin connection' do
    it "cannot access the 'new' action" do
      admin = create(:user, :admin)

      login_as admin, scope: :user
      get '/payment_methods/new'

      expect(response).to redirect_to(admin_home_index_path)
    end

    it "cannot access the 'create' action" do
      admin = create(:user, :admin)

      login_as admin, scope: :user
      post '/payment_methods'

      expect(response).to redirect_to(admin_home_index_path)
    end

    it "cannot access the 'show' action" do
      admin = create(:user, :admin)

      login_as admin, scope: :user
      get '/payment_methods/1'

      expect(response).to redirect_to(admin_home_index_path)
    end
  end
end
