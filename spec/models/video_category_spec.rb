require 'rails_helper'

RSpec.describe VideoCategory, type: :model do
  describe 'associations' do
    it do
      should have_many(:sub_categories).class_name('VideoCategory').with_foreign_key(:parent_id).inverse_of(:parent)
                                       .dependent(:restrict_with_error)
    end
    it { should belong_to(:parent).class_name('VideoCategory').optional.inverse_of(:sub_categories) }
  end

  describe 'presence' do
    it { should validate_presence_of(:title) }
  end

  describe 'uniqueness' do
    it { should validate_uniqueness_of(:title) }
  end
end
