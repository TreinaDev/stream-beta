class VideoCategory < ApplicationRecord
  has_many :sub_categories, class_name: 'VideoCategory', foreign_key: 'parent_id', inverse_of: :parent
  belongs_to :parent, class_name: 'VideoCategory', optional: true, inverse_of: :sub_categories

  validates :title, presence: true
  validates :title, uniqueness: true
end
