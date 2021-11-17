class VideoCategory < ApplicationRecord
  validates :title, presence: true
  validates :title, uniqueness: true

  has_many :sub_categories, class_name: 'VideoCateogory', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'VideoCategory', optional: true
end
