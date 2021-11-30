require 'rails_helper'

RSpec.describe ProductReceipt, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:product) }
    it { should belong_to(:payment_method) }
  end
end
