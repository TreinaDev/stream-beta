require 'rails_helper'

RSpec.describe SubscriptionPlanStreamer, type: :model do
  context 'associations' do
    it { should belong_to(:subscription_plan) }
    it { should belong_to(:streamer) }
  end
end
