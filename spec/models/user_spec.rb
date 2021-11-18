require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_one(:user_profile).dependent(:destroy) }
  end
end
