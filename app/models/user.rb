class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes

  validates :email, presence: false, uniqueness: false, allow_blank: true
  validates :password_digest, presence: false, uniqueness: false, allow_blank: true

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
