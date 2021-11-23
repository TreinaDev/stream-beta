require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
  end

  context 'enum' do
    it { should define_enum_for(:payment_type).with_values(pix: 10, boleto: 20, credit_card: 30) }
  end

  context 'format' do
    it { should allow_values('abcABC1234').for(:token) }
    it { should_not allow_values('abcABC123').for(:token) }
    it { should_not allow_values('abcABC12345').for(:token) }
  end
end
