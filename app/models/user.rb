class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true

  validates :password, presence: true, on: :update, allow_blank: true

  validates :first_name, presence: true
  enum role: { default: 0, admin: 1 }
  has_secure_password

  def bookmarked_videos
    videos.order(:tutorial_id, :position)
  end

  def status
    return 'Status: Active' if active

    'Confirm email to activate your account'
  end
end
