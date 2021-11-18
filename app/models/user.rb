class User < ApplicationRecord
  has_one :payment_method, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :user_profile, dependent: :destroy

  before_save :admin_save

  private

  def admin_save
    self.admin = email.match?(/.*@gamestream.com.br/)
  end
end
