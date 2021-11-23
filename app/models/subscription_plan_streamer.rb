class SubscriptionPlanStreamer < ApplicationRecord
  belongs_to :subscription_plan
  belongs_to :streamer
end
