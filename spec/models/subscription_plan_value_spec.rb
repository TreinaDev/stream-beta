require 'rails_helper'

RSpec.describe SubscriptionPlanValue, type: :model do
  describe 'presence' do
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:value) }
  end

  describe 'uniqueness' do
    subject { build(:subscription_plan_value) }

    it { should validate_uniqueness_of(:start_date).scoped_to(:subscription_plan_id) }
    it { should validate_uniqueness_of(:end_date).scoped_to(:subscription_plan_id) }
  end

  describe 'numericality' do
    it { should validate_numericality_of(:value).is_greater_than(0) }
  end
end
