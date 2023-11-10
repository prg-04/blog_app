# spec/models/like_spec.rb
require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user:) }

  it 'should belong to a post and a user' do
    like = Like.new(post:, user:)
    expect(like.post).to eq(post), 'Like should belong to the specified post'
    expect(like.user).to eq(user), 'Like should belong to the specified user'
  end

  it "should increment post's likesCounter after creation" do
    expect do
      create(:like, post:, user:)
    end.to change { post.reload.likesCounter }.by(1)
  end

  it 'should not be valid without a post' do
    like = build(:like, post: nil, user:)
    expect(like).not_to be_valid, 'Like is valid without a post'
  end

  it 'should not be valid without a user' do
    like = build(:like, post:, user: nil)
    expect(like).not_to be_valid, 'Like is valid without a user'
  end
end
