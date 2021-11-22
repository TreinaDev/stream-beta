require 'rails_helper'

RSpec.describe SubscriptionPlanPlaylist, type: :model do
  context 'associations' do
    it { should belong_to(:subscription_plan) }
    it { should belong_to(:playlist) }
  end
end
