class Post < ApplicationRecord
  belongs_to :user, foreign_key: 'AuthorId'

  after_create :increment_user_posts_counter

  private

  def increment_user_posts_counter
    user.increment!(:PostsCounter).save
  end
end
