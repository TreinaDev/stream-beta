require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
  end

  context 'enum' do
    it { should define_enum_for(:payment_type).with_values(pix: 10, boleto: 20, credit_card: 30) }
  end

  context 'presence' do
    it { should validate_presence_of(:token) }
  end

  context 'uniqueness' do
    subject { build(:payment_method) }

    it { should validate_uniqueness_of(:token) }
  end

  context 'format' do
    it { should allow_values('abcABC1234').for(:token) }
    it { should_not allow_values('abcABC123').for(:token) }
    it { should_not allow_values('abcABC12345').for(:token) }
  end

  describe '#generate_new_token' do
    let(:user_payment_method) { JSON.parse(File.read(Rails.root.join('spec/support/apis/user_payment_method.json'))) }

    subject { PaymentMethod.new(user_payment_method: user_payment_method) }

    it 'successfully' do
      api_response = File.read(Rails.root.join('spec/support/apis/user_payment_method_response.json'))
      fake_response = instance_double(Faraday::Response, status: 201, body: api_response)
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/payment_methods/',
                                            user_payment_method.to_json, { 'Content-Type' => 'application/json' })
                                      .and_return(fake_response)

      subject.request_token
      expect(subject.token).to eq 'BYZBrjim0W'
    end

    it 'and fails due to server error' do
      fake_response = instance_double(Faraday::Response, status: 500, body: '')
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/payment_methods/',
                                            user_payment_method.to_json, { 'Content-Type' => 'application/json' })
                                      .and_return(fake_response)

      subject.request_token
      expect(subject.token).to eq nil
    end
  end
end
