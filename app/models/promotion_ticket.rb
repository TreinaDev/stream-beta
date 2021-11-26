class PromotionTicket < ApplicationRecord
  validates :title, :discount, :maximum_value_reduction,
            :maximum_uses, :start_date, :end_date, presence: true
end
