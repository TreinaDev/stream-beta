require 'rails_helper'

RSpec.describe UserProfile, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'presence' do
    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:social_name) }
    it { should validate_presence_of(:birth_date) }
    it { should validate_presence_of(:cpf) }
    it { should validate_presence_of(:zipcode) }
    it { should validate_presence_of(:address_line_one) }
    it { should validate_presence_of(:address_line_two) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:country) }
  end

  describe 'uniqueness' do
    subject { build(:user_profile) }

    it { should validate_uniqueness_of(:cpf).case_insensitive }
  end

  describe '#create_or_update_account_holder' do
    let(:header) do
      { 'Content-Type' => 'application/json', 'company_token' => Rails.configuration.api_pagapaga[:company_token] }
    end

    context 'when creating account_holder' do
      it 'successfully' do
        user_profile = create(:user_profile, full_name: 'João da Silva')
        account_holder = { name: user_profile.full_name, cpf: user_profile.cpf, birth_date: user_profile.birth_date }
        api_response = { ok: 'Cadastro criado com sucesso' }.to_json
        fake_response = instance_double(Faraday::Response, status: 201, body: api_response)
        allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/account_holders/',
                                              account_holder.to_json, header).and_return(fake_response)

        result = user_profile.create_or_update_account_holder
        expect(result).to eq 'Cadastro criado com sucesso'
      end

      it 'and fails due to server error' do
        user_profile = create(:user_profile, full_name: 'João da Silva')
        account_holder = { name: user_profile.full_name, cpf: user_profile.cpf, birth_date: user_profile.birth_date }
        fake_response = instance_double(Faraday::Response, status: 500, body: '')
        allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/account_holders/',
                                              account_holder.to_json, header).and_return(fake_response)

        result = user_profile.create_or_update_account_holder
        expect(result.details.as_json).to eq({ 'error' => 'Ocorreu um erro no servidor externo' })
      end
    end

    context 'when updating account_holder' do
      it 'successfully' do
        user_profile = create(:user_profile, full_name: 'João da Silva')
        account_holder = { name: user_profile.full_name, cpf: user_profile.cpf, birth_date: user_profile.birth_date }
        api_response = { ok: 'Cadastro atualizado com sucesso' }.to_json
        fake_response = instance_double(Faraday::Response, status: 200, body: api_response)
        allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/account_holders/',
                                              account_holder.to_json, header).and_return(fake_response)

        result = user_profile.create_or_update_account_holder
        expect(result).to eq 'Cadastro atualizado com sucesso'
      end
    end
  end

  describe 'check_cpf_format' do
    subject { build(:user_profile, cpf: cpf) }

    context 'should not be valid' do
      let(:cpf) { '12345678901' }

      it do
        subject.valid?
        expect(subject.errors.full_messages_for(:cpf)).to include('CPF não é válido')
      end
    end

    context 'should be valid' do
      let(:cpf) { '40849435170' }

      it do
        subject.valid?
        expect(subject.errors.full_messages_for(:cpf)).to be_empty
      end
    end
  end
end
