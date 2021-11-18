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
