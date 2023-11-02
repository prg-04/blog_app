class Comment < ApplicationRecord
  belongs_to :post, foreign_key: 'PostId'

  after_create :increment_post_comments_counter

  private

  def increment_post_comments_counter
    post.increment!(:CommentsCounter).save
  end
end
