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

  describe '.available_payment_methods' do
    let(:header) do
      { 'Content-Type' => 'application/json', 'company_token' => Rails.configuration.api_pagapaga[:company_token] }
    end

    it 'when all payment methods are available' do
      api_response = File.read(Rails.root.join('spec/support/apis/available_payment_methods/all.json'))
      fake_response = instance_double(Faraday::Response, status: 200, body: api_response)
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/available_payment_methods/', {}, header)
                                     .and_return(fake_response)

      available_payment_methods = PaymentMethod.available_payment_methods
      expect(available_payment_methods).to include('pix')
      expect(available_payment_methods).to include('boleto')
      expect(available_payment_methods).to include('credit_card')
    end

    it 'when only pix is available' do
      api_response = File.read(Rails.root.join('spec/support/apis/available_payment_methods/only_pix.json'))
      fake_response = instance_double(Faraday::Response, status: 200, body: api_response)
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/available_payment_methods/', {}, header)
                                     .and_return(fake_response)

      available_payment_methods = PaymentMethod.available_payment_methods
      expect(available_payment_methods).to include('pix')
      expect(available_payment_methods).to_not include('boleto')
      expect(available_payment_methods).to_not include('credit_card')
    end

    it 'when only boleto is available' do
      api_response = File.read(Rails.root.join('spec/support/apis/available_payment_methods/only_boleto.json'))
      fake_response = instance_double(Faraday::Response, status: 200, body: api_response)
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/available_payment_methods/', {}, header)
                                     .and_return(fake_response)

      available_payment_methods = PaymentMethod.available_payment_methods
      expect(available_payment_methods).to_not include('pix')
      expect(available_payment_methods).to include('boleto')
      expect(available_payment_methods).to_not include('credit_card')
    end

    it 'when only credit_card is available' do
      api_response = File.read(Rails.root.join('spec/support/apis/available_payment_methods/only_credit_card.json'))
      fake_response = instance_double(Faraday::Response, status: 200, body: api_response)
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/available_payment_methods/', {}, header)
                                     .and_return(fake_response)

      available_payment_methods = PaymentMethod.available_payment_methods
      expect(available_payment_methods).to_not include('pix')
      expect(available_payment_methods).to_not include('boleto')
      expect(available_payment_methods).to include('credit_card')
    end

    it 'when no payment methods are available' do
      fake_response = instance_double(Faraday::Response, status: 200, body: [])
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/available_payment_methods/', {}, header)
                                     .and_return(fake_response)

      available_payment_methods = PaymentMethod.available_payment_methods
      expect(available_payment_methods).to_not include('pix')
      expect(available_payment_methods).to_not include('boleto')
      expect(available_payment_methods).to_not include('credit_card')
    end

    it 'fails due to server error' do
      fake_response = instance_double(Faraday::Response, status: 500, body: '')
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/available_payment_methods/', {}, header)
                                     .and_return(fake_response)

      available_payment_methods = PaymentMethod.available_payment_methods
      expect(available_payment_methods).to eq({ message: 'Ocorreu um erro no servidor externo' })
    end
  end

  describe '#generate_new_token' do
    let(:user_payment_method) do
      JSON.parse(File.read(Rails.root.join('spec/support/apis/user_payment_methods/credit_card.json')))
    end
    let(:header) do
      { 'Content-Type' => 'application/json', 'company_token' => Rails.configuration.api_pagapaga[:company_token] }
    end

    subject { PaymentMethod.new(user_payment_method: UserPaymentMethod.new(user_payment_method)) }

    it 'successfully' do
      api_response = File.read(Rails.root.join('spec/support/apis/user_payment_methods/response.json'))
      fake_response = instance_double(Faraday::Response, status: 201, body: api_response)
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/payment_methods/',
                                            user_payment_method.to_json, header).and_return(fake_response)

      subject.request_token
      expect(subject.token).to eq 'BYZBrjim0W'
    end

    it 'and fails due to server error' do
      fake_response = instance_double(Faraday::Response, status: 500, body: '')
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/payment_methods/',
                                            user_payment_method.to_json, header).and_return(fake_response)

      subject.request_token
      expect(subject.token).to eq nil
    end
  end
end
