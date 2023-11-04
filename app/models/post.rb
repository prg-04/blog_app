class Post < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  has_many :comments
  has_many :likes

  after_create :increment_user_posts_counter


   def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def increment_user_posts_counter
    user.increment!(:PostsCounter).save
  end
end


  