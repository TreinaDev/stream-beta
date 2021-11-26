class SubscriptionPlan < ApplicationRecord
  has_many :subscription_plan_values, dependent: :destroy

  has_many :user_subscription_plans, dependent: :restrict_with_error
  has_many :users, through: :user_subscription_plans

  has_many :subscription_plan_playlists, dependent: :destroy
  has_many :playlists, through: :subscription_plan_playlists

  has_one :subscription_plan_streamer, dependent: :destroy
  has_one :streamer, through: :subscription_plan_streamer

  enum plan_type: { playlist: 10, streamer: 20 }

  validates :title, :description, :token, :value, presence: true
  validates :token, uniqueness: true
  validates :title, uniqueness: { case_sensitive: false }
  validates :value, numericality: { greater_than: 0 }
  validates :token, format: { with: /\A[a-zA-Z0-9]{10}\z/ }

  before_validation :request_token

  def current_value
    subscription_plan_values.filter_by_date(Date.current).pick(:value) || value
  end

  def request_token
    self.token = generate_new_token(title, current_value) if token.nil?
  end

  private

  def generate_new_token(title, value)
    token_params = { title: title, value: value }

    data = ApiClient.post('subscription_plans', token_params.to_json)

    unless data&.key?(:subscription_plan_token)
      errors.add(:api_connection, I18n.t('messages.api_connection_error'))
      return nil
    end

    data[:subscription_plan_token]
  end
end
