require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }

  describe 'validations' do
    it 'is valid with valid attributes' do
      post = Post.new(
        author: user,
        title: 'Welcome',
        comments_counter: 0,
        likes_counter: 0,
        text: 'Good Morning'
      )
      expect(post).to be_valid
    end

    it 'is not valid without a title' do
      post = Post.new(
        author: user,
        title: nil,
        text: 'Blank Welcome'
      )
      expect(post).not_to be_valid
    end

    it 'is not valid with a title exceeding 250 characters' do
      post = Post.new(
        author: user,
        title: 'A' * 251,
        text: 'Exceeded Limit'
      )
      expect(post).not_to be_valid
    end

    it 'is not valid with a negative comments_counter' do
      post = Post.new(
        author: user,
        title: 'Negative comment counts',
        comments_counter: -1,
        text: 'Some text content'
      )
      expect(post).not_to be_valid
    end

    it 'is not valid with a negative likes_counter' do
      post = Post.new(
        author: user,
        title: 'Negative Like counts',
        likes_counter: -1,
        text: 'Some text content'
      )
      expect(post).not_to be_valid
    end

    it 'is not valid without text' do
      post = Post.new(
        author: user,
        title: 'Without text',
        text: nil
      )
      expect(post).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to an author (User)' do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq :belongs_to
    end

    it 'has many likes' do
      association = described_class.reflect_on_association(:likes)
      expect(association.macro).to eq :has_many
    end

    it 'has many comments' do
      association = described_class.reflect_on_association(:comments)
      expect(association.macro).to eq :has_many
    end
  end

  describe '#recent_comments' do
    it 'returns the specified number of most recent comments' do
      post = Post.create(author: user, title: 'Test Post', text: 'Mission Impossible five is the best')
      Comment.create(text: 'Comment 1', author: user, post:)
      comment2 = Comment.create(text: 'Comment 2', author: user, post:)
      comment3 = Comment.create(text: 'Comment 3', author: user, post:)

      recent_comments = post.recent_comments(2)
      expect(recent_comments).to eq([comment3, comment2])
    end
  end
end
