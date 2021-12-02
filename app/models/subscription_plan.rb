class SubscriptionPlan < ApplicationRecord
  has_many :subscription_plan_values, dependent: :destroy

  has_many :user_subscription_plans, dependent: :restrict_with_error
  has_many :users, through: :user_subscription_plans

  has_many :subscription_plan_playlists, dependent: :destroy
  has_many :playlists, through: :subscription_plan_playlists

  has_one :subscription_plan_streamer, dependent: :destroy
  has_one :streamer, through: :subscription_plan_streamer

  has_one :subscription_plan_promotion_ticket, dependent: :destroy
  has_one :promotion_ticket, through: :subscription_plan_promotion_ticket

  enum plan_type: { playlist: 10, streamer: 20 }
  enum status: { active: 15, inactive: 25 }

  validates :title, :description, :token, :value, presence: true
  validates :token, uniqueness: true
  validates :title, uniqueness: { case_sensitive: false }
  validates :value, numericality: { greater_than: 0 }
  validates :token, format: { with: /\A[a-zA-Z0-9]{10}\z/ }

  before_commit :test_for_subscription_plan_values, only: %i[current_value promotional_value]

  before_validation :request_token

  def current_value
    return test_for_subscription_plan_values if promotion_ticket.blank?

    promotional_value(test_for_subscription_plan_values)
  end

  def request_token
    self.token = generate_new_token(title, current_value) if token.nil?
  end

  private

  def promotional_value(value)
    current_discount = (value * promotion_ticket.discount / 100)
    calculate_promotion_ticket_reduction_value(current_discount)
  end

  def calculate_promotion_ticket_reduction_value(current_discount)
    if current_discount > promotion_ticket.maximum_value_reduction
      test_for_subscription_plan_values - promotion_ticket.maximum_value_reduction
    else
      test_for_subscription_plan_values - current_discount
    end
  end

  def test_for_subscription_plan_values
    (subscription_plan_values.filter_by_date(Date.current).pick(:value) || value)
  end

  def generate_new_token(title, value)
    token_params = { title: title, value: value }

    data = ApiPagapaga.post('subscription_products', token_params.to_json)

    unless data&.key?(:product_token)
      errors.add(:api_connection, data[:message])
      return nil
    end

    data[:product_token]
  end
end
