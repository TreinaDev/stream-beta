require 'rails_helper'

describe 'Restricted promotion ticket routes' do
  context 'when unauthenticated' do
    it "can't access the 'create' action" do
      post '/promotion_tickets'

      expect(response).to redirect_to(new_user_session_path)
    end

    it "can't access the 'new' action" do
      get '/promotion_tickets/new'

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'when logged in as an user' do
    before :context do
      @user = create(:user)
    end

    it "can't access the 'create' action" do
      login_as @user, scope: :user
      post '/promotion_tickets'

      expect(response).to redirect_to(root_path)
    end

    it "can't access the 'new' action" do
      login_as @user, scope: :user
      get '/promotion_tickets/new'

      expect(response).to redirect_to(root_path)
    end
  end
end
