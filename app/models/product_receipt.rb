class ProductReceipt < ApplicationRecord
  belongs_to :user
  belongs_to :product, polymorphic: true
  belongs_to :payment_method
end
