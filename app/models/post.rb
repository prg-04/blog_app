class Post < ApplicationRecord
  belongs_to :user

  has_many :comments
  has_many :likes

  after_create :increment_user_posts_counter

  validates :title, presence: true, length: { maximum: 250 }
  validates :commentsCounter, numericality: { greater_than_or_equal_to: 0 }
  validates :likesCounter, numericality: { greater_than_or_equal_to: 0 }


  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def increment_user_posts_counter
    user.increment!(:postCounter).save
  end
end
