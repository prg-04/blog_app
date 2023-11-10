class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes

  validates :name, presence: true, uniqueness: false
  validates :email, presence: false, uniqueness: false, allow_blank: true
  validates :password_digest, presence: false, uniqueness: false, allow_blank: true
  validates :postCounter, numericality: { greater_than_or_equal_to: 0 }

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
