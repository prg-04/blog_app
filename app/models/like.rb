class Like < ApplicationRecord
    belongs_to :post, foreign_key: 'PostId'

    after_create :increment_post_likes_counter

    private

    def increment_post_likes_counter
        post.increment!(:LikesCounter).save
    end
end
