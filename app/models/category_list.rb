class CategoryList < ApplicationRecord
  belongs_to :video_category
  belongs_to :categoriable, polymorphic: true
end
