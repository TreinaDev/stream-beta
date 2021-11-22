class SubscriptionPlanPlaylist < ApplicationRecord
  belongs_to :subscription_plan
  belongs_to :playlist
end
