class Comment < ApplicationRecord
  belongs_to :post, foreign_key: 'post_id'
  belongs_to :user, foreign_key: 'user_id'

  after_create :increment_post_comments_counter

  private

  def increment_post_comments_counter
    post.increment!(:CommentsCounter).save
  end
end
