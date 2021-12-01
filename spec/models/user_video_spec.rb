require 'rails_helper'

RSpec.describe UserVideo, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:video) }
    it { should have_one(:product_receipt).dependent(:restrict_with_error) }
  end

  context 'enum' do
    it { should define_enum_for(:status).with_values(pending: 10, approved: 50, rejected: 90) }
  end

  describe '#confirm_payment' do
    let(:user_video) { JSON.parse(File.read(Rails.root.join('spec/support/apis/user_video.json'))) }
    let(:video) { create(:video, :allow_purchase) }
    let(:user) { create(:user, create_profile: true) }

    let(:header) do
      { 'Content-Type' => 'application/json', 'company_token' => Rails.configuration.api_pagapaga[:company_token] }
    end

    subject { UserVideo.create!(user_video.merge(video: video, user: user)) }

    it 'successfully' do
      create(:payment_method, token: user_video['payment_method_token'], user: user)
      api_response = File.read(Rails.root.join('spec/support/apis/user_video_response.json'))
      fake_response = instance_double(Faraday::Response, status: 201, body: api_response)
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/product_purchase/',
                                            user_video.to_json, header).and_return(fake_response)

      subject.confirm_payment
      expect(subject.product_receipt.receipt_token).to eq 'h7d6yy79YO'
    end

    it 'and fails due to server error' do
      fake_response = instance_double(Faraday::Response, status: 500, body: '')
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/product_purchase/',
                                            user_video.to_json, header).and_return(fake_response)

      subject.confirm_payment
      expect(subject.product_receipt).to eq nil
    end
  end

  describe '#change_status' do
    subject { create(:user_video) }

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
