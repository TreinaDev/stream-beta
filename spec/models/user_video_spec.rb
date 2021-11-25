require 'rails_helper'

RSpec.describe UserVideo, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:video) }
  end

  context 'enum' do
    it { should define_enum_for(:status).with_values(pending: 10, approved: 50, rejected: 90) }
  end
end