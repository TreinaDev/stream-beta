require 'rails_helper'

RSpec.describe SubscriptionPlanPromotionTicket, type: :model do
  describe 'associations' do
    it { should belong_to(:subscription_plan) }
    it { should belong_to(:promotion_ticket) }
  end
end
