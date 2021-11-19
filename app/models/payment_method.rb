class PaymentMethod < ApplicationRecord
  belongs_to :user
  validates :token, length: { is: 10 }
end
