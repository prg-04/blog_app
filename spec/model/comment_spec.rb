# spec/models/comment_spec.rb
require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user:) }

  it 'should belong to a post and a user' do
    comment = build(:comment, post:, user:)
    expect(comment.post).to eq(post), 'Comment should belong to the specified post'
    expect(comment.user).to eq(user), 'Comment should belong to the specified user'
  end

  it 'should be valid with valid attributes' do
    comment = build(:comment, post:, user:)
    expect(comment).to be_valid, 'Comment is not valid with valid attributes'
  end

  it 'should not be valid without text' do
    comment = build(:comment, post:, user:, text: nil)
    expect(comment).not_to be_valid, "Comment is valid without text. Errors: #{comment.errors.full_messages}"
  end
end
