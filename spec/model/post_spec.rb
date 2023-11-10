# spec/models/post_spec.rb
require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) } # Assuming you have a User factory or fixture

  it 'should belong to a user' do
    post = Post.new(user:)
    expect(post.user).to eq(user), 'Post should belong to the specified user'
  end

  it 'should have many comments and likes' do
    post = Post.new
    expect(post).to respond_to(:comments), 'Post should respond to comments association'
    expect(post).to respond_to(:likes), 'Post should respond to likes association'
  end

  it "should increment user's postCounter after creation" do
    expect do
      create(:post, user:)
    end.to change { user.reload.postCounter }.by(1)
  end

  it 'should have a recent_comments method' do
    post = create(:post)
    5.times { create(:comment, post:) }

    expect(post.recent_comments.length).to eq(5),
                                           "Post's recent_comments doesn't return the expected number of comments"
  end

  it 'should be valid with valid attributes' do
    post = build(:post, user:)
    expect(post).to be_valid, 'Post is not valid with valid attributes'
  end

  it 'should validate the presence of title' do
    post = build(:post, user:, title: nil)
    expect(post).not_to be_valid, 'Post is valid without a title'
  end

  it 'should validate the length of title' do
    post = build(:post, user:, title: 'a' * 251)
    expect(post).not_to be_valid, 'Post is valid with a title longer than 250 characters'
  end

  it 'should validate the presence of text' do
    post = build(:post, user:, text: nil)
    expect(post).to be_valid, 'Post is not valid without text'
  end

  it 'should validate commentsCounter to be greater than or equal to 0' do
    post = build(:post, user:, commentsCounter: -1)
    expect(post).not_to be_valid, 'Post is valid with negative commentsCounter'
  end

  it 'should validate likesCounter to be greater than or equal to 0' do
    post = build(:post, user:, likesCounter: -1)
    expect(post).not_to be_valid, 'Post is valid with negative likesCounter'
  end
end
