require 'rails_helper'

RSpec.describe SubscriptionPlan, type: :model do
  context 'presence' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:value) }
  end

  context 'uniqueness' do
    it { should validate_uniqueness_of(:title) }
  end

  context 'numericality' do
    it {should validate_numericality_of(:value).is_greater_than(0)}
  end
end
