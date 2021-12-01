class VideoCategory < ApplicationRecord
  has_many :sub_categories, class_name: 'VideoCategory', foreign_key: 'parent_id', inverse_of: :parent,
                            dependent: :restrict_with_error
  belongs_to :parent, class_name: 'VideoCategory', optional: true, inverse_of: :sub_categories

  enum status: { active: 10, canceled: 15 }

  validates :title, presence: true
  validates :title, uniqueness: true
end
