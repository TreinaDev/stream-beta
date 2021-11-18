require 'rails_helper'

RSpec.describe User, type: :model do
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
