require 'rails_helper'

RSpec.describe SubscriptionPlanValue, type: :model do
  describe 'enum' do
    it { should define_enum_for(:status).with_values(active: 10, canceled: 90) }
  end

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

  describe 'dates_cannot_overlap' do
    before do
      create(:subscription_plan_value, start_date: 1.day.from_now, end_date: 5.days.from_now)
    end

    context 'start_date overlaps' do
      subject { build(:subscription_plan_value, start_date: 3.days.from_now, end_date: 10.days.from_now) }

      it {
        subject.valid?
        expect(subject.errors.full_messages_for(:start_date)).to include('Data inicial corresponde a um período já cadastrado')
      }
    end

    context 'end_date overlaps' do
      subject { build(:subscription_plan_value, start_date: Date.current, end_date: 5.days.from_now) }

      it {
        subject.valid?
        expect(subject.errors.full_messages_for(:end_date)).to include('Data final corresponde a um período já cadastrado')
      }
    end
  end
end
