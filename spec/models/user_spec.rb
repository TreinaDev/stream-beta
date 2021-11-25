require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:payment_methods).dependent(:destroy) }

    it { should have_many(:user_subscription_plans).dependent(:restrict_with_error) }
    it { should have_many(:subscription_plans).through(:user_subscription_plans) }

    it { should have_many(:user_videos).dependent(:restrict_with_error) }
    it { should have_many(:videos).through(:user_videos) }

    it { should have_one(:user_profile).dependent(:destroy) }
  end

  describe 'admin_save' do
    subject { create(:user, email: email) }

    context 'when email domain matches gamestream.com.br' do
      let(:email) { 'teste@gamestream.com.br' }

      it { expect(subject).to be_admin }
    end

    context 'when email domain does not match gamestream.com.br' do
      let(:email) { 'teste@gmail.com' }

      it { expect(subject).to_not be_admin }
    end
  end
end
