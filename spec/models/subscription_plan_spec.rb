require 'rails_helper'

RSpec.describe SubscriptionPlan, type: :model do
  describe 'associations' do
    it { should have_many(:subscription_plan_values).dependent(:destroy) }

    it { should have_many(:user_subscription_plans) }
    it { should have_many(:users).through(:user_subscription_plans) }
  end

  describe 'presence' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:value) }
  end

  describe 'uniqueness' do
    it { should validate_uniqueness_of(:title).case_insensitive }
  end

  describe 'numericality' do
    it { should validate_numericality_of(:value).is_greater_than(0) }
  end

  describe '.current_value' do
    subject do
      create(:subscription_plan, value: 20)
    end

    context 'when there are values for the current date' do
      it do
        create(:subscription_plan_value, subscription_plan: subject, start_date: Date.current,
                                         end_date: 2.days.from_now, value: 30)

        expect(subject.current_value).to eq 30
      end
    end

    context 'when there are no values for the current date' do
      it do
        create(:subscription_plan_value, subscription_plan: subject, start_date: 1.day.from_now,
                                         end_date: 2.days.from_now, value: 30)

        expect(subject.current_value).to eq 20
      end
    end

    context 'when there are no dynamic values' do
      it { expect(subject.current_value).to eq 20 }
    end
  end
end
