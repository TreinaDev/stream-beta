require 'rails_helper'

RSpec.describe UserSubscriptionPlan, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:subscription_plan) }
  end
end
