class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes

  validates :bio, presence: true
  validates :name, presence: true, uniqueness: false
  validates :postsCounter, numericality: { greater_than_or_equal_to: 0 }

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
