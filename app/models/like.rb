class Like < ApplicationRecord
  belongs_to :post, foreign_key: 'post_id'
  belongs_to :user, foreign_key: 'user_id'

  after_create :increment_post_likes_counter

  private

  def increment_post_likes_counter
    post.increment!(:likesCounter).save
  end
end
