class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :payment_methods, dependent: :destroy

  has_many :user_subscription_plans, dependent: :restrict_with_error
  has_many :subscription_plans, through: :user_subscription_plans

  has_many :user_videos, dependent: :restrict_with_error
  has_many :videos, through: :user_videos

  has_one :user_profile, dependent: :destroy

  before_save :admin_save

  private

  def admin_save
    self.admin = email.match?(/.*@gamestream.com.br/)
  end
end
