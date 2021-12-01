require 'rails_helper'

RSpec.describe PromotionTicket, type: :model do
  describe 'associations' do
    it { should have_many(:subscription_plan_promotion_tickets).dependent(:destroy) }
    it { should have_many(:subscription_plans).through(:subscription_plan_promotion_tickets) }
  end

  describe 'presence' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:maximum_value_reduction) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:maximum_uses) }
    it { should validate_presence_of(:discount) }
  end

  describe 'numericality' do
    it { should validate_numericality_of(:maximum_value_reduction).is_greater_than(0) }
    it { should validate_numericality_of(:maximum_uses).is_greater_than(0) }
    it { should validate_numericality_of(:discount).is_greater_than(0) }
  end

  describe 'uniqueness' do
    subject { build(:promotion_ticket) }

    it { should validate_uniqueness_of(:title) }
  end

  describe 'end_date_cannot_come_before_start_date' do
    subject { build(:promotion_ticket, start_date: start_date, end_date: end_date) }

    context 'start_date comes before end_date' do
      let(:start_date) { 2.days.from_now }
      let(:end_date) { 3.days.from_now }

      it do
        subject.valid?
        expect(subject.errors.full_messages_for(:end_date)).to be_empty
      end
    end

    context 'start_date is the same as end_date' do
      let(:start_date) { 2.days.from_now }
      let(:end_date) { 2.days.from_now }

      it do
        subject.valid?
        expect(subject.errors.full_messages_for(:end_date)).to be_empty
      end
    end

    context 'start_date comes after end_date' do
      let(:start_date) { 3.days.from_now }
      let(:end_date) { 2.days.from_now }

      it do
        subject.valid?
        expect(subject.errors.full_messages_for(:end_date))
          .to include('Data final deve ser maior ou igual a data inicial')
      end
    end
  end

  describe 'cannot_start_before_current_date' do
    subject { build(:promotion_ticket, start_date: start_date) }

    context 'start_date comes before current date' do
      let(:start_date) { 1.day.ago }

      it do
        subject.valid?
        expect(subject.errors.full_messages_for(:start_date))
          .to include('Data inicial deve ser maior ou igual a data atual')
      end
    end

    context 'start_date is the same as current date' do
      let(:start_date) { Date.current }

      it do
        subject.valid?
        expect(subject.errors.full_messages_for(:start_date)).to eq []
      end
    end

    context 'start_date comes after current date' do
      let(:start_date) { 1.day.from_now }

      it do
        subject.valid?
        expect(subject.errors.full_messages_for(:start_date)).to eq []
      end
    end
  end
end
