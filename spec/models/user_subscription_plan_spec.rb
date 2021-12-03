require 'rails_helper'

RSpec.describe UserSubscriptionPlan, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:subscription_plan) }
    it { should have_many(:product_receipts).dependent(:restrict_with_error) }
  end

  context 'enum' do
    it { should define_enum_for(:status).with_values(pending: 10, approved: 50, rejected: 90) }
  end

  describe '#confirm_payment' do
    let(:user_subscription_plan) do
      JSON.parse(File.read(Rails.root.join('spec/support/apis/user_subscription_plan.json')))
    end
    let(:subscription_plan) { create(:subscription_plan) }
    let(:user) { create(:user, create_profile: true) }

    let(:header) do
      { 'Content-Type' => 'application/json', 'company_token' => Rails.configuration.api_pagapaga[:company_token] }
    end

    subject do
      UserSubscriptionPlan.create!(user_subscription_plan.merge(subscription_plan: subscription_plan, user: user))
    end

    it 'successfully' do
      create(:payment_method, token: user_subscription_plan['payment_method_token'], user: user)
      api_response = File.read(Rails.root.join('spec/support/apis/user_subscription_plan_response.json'))
      fake_response = instance_double(Faraday::Response, status: 201, body: api_response)
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/subscription_product_payments/',
                                            user_subscription_plan.to_json, header).and_return(fake_response)

      subject.confirm_payment
      expect(subject.product_receipts.last.receipt_token).to eq 'S5sqQ4KPRD'
    end

    it 'and fails due to server error' do
      fake_response = instance_double(Faraday::Response, status: 500, body: '')
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/subscription_product_payments/',
                                            user_subscription_plan.to_json, header).and_return(fake_response)

      subject.confirm_payment
      expect(subject.product_receipts).to be_empty
    end
  end

  describe '#change_status' do
    subject { create(:user_subscription_plan) }

    context "when payment_status is 'approved'" do
      it do
        subject.change_status('approved')
        expect(subject).to be_approved
      end
    end

    context "when payment_status is 'pending'" do
      it do
        subject.change_status('pending')
        expect(subject).to be_pending
      end
    end

    context "when payment_status is 'rejected'" do
      it do
        subject.change_status('rejected')
        expect(subject).to be_rejected
      end
    end

    context "when payment_status is 'other'" do
      it do
        subject.change_status('other')
        expect(subject).to be_pending
        expect(subject.errors.full_messages_for(:status)).to include('Situação inválida')
      end
    end
  end
end
