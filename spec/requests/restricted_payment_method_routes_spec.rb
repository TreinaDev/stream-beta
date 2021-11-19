require 'rails_helper'

describe 'Restricted payment method routes' do
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
end
