require 'rails_helper'

RSpec.describe SubscriptionPlan, type: :model do
  describe 'associations' do
    it { should have_many(:subscription_plan_values).dependent(:destroy) }

    it { should have_many(:user_subscription_plans) }
    it { should have_many(:users).through(:user_subscription_plans) }

    it { should have_many(:subscription_plan_playlists).dependent(:destroy) }
    it { should have_many(:playlists).through(:subscription_plan_playlists) }

    it { should have_one(:subscription_plan_streamer).dependent(:destroy) }
    it { should have_one(:streamer).through(:subscription_plan_streamer) }

    it { should have_one(:subscription_plan_promotion_ticket).dependent(:destroy) }
    it { should have_one(:promotion_ticket).through(:subscription_plan_promotion_ticket) }
  end

  describe 'enum' do
    it { should define_enum_for(:plan_type).with_values(playlist: 10, streamer: 20) }
  end

  describe 'presence' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:value) }
    it { should validate_presence_of(:token) }
  end

  describe 'uniqueness' do
    subject { build(:subscription_plan) }

    it { should validate_uniqueness_of(:title).case_insensitive }
    it { should validate_uniqueness_of(:token) }
  end

  describe 'numericality' do
    it { should validate_numericality_of(:value).is_greater_than(0) }
  end

  context 'format' do
    it { should allow_values('abcABC1234').for(:token) }
    it { should_not allow_values('abcABC123').for(:token) }
    it { should_not allow_values('abcABC12345').for(:token) }
  end

  describe '#current_value' do
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

  describe '#generate_new_token' do
    let(:subscription_plan) { JSON.parse(File.read(Rails.root.join('spec/support/apis/subscription_plan.json'))) }
    let(:header) do
      { 'Content-Type' => 'application/json', 'company_token' => Rails.configuration.api_pagapaga[:company_token] }
    end

    subject do
      SubscriptionPlan.new(subscription_plan)
    end

    it 'successfully' do
      api_response = File.read(Rails.root.join('spec/support/apis/subscription_plan_response.json'))
      fake_response = instance_double(Faraday::Response, status: 201, body: api_response)
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/subscription_plans/',
                                            subscription_plan.to_json, header).and_return(fake_response)

      subject.request_token
      expect(subject.token).to eq 'BYZBrjim0W'
    end

    it 'and fails due to server error' do
      fake_response = instance_double(Faraday::Response, status: 500, body: '')
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/subscription_plans/',
                                            subscription_plan.to_json, header).and_return(fake_response)

      subject.request_token
      expect(subject.token).to eq nil
    end
  end
end
