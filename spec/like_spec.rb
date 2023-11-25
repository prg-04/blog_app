require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let(:post) { Post.create(author: user, title: 'Mission Impossible', text: 'Fallout') }
  let(:like) { Like.create(user:, post:) }

  it 'is valid with valid attributes' do
    expect(like).to be_valid
  end

  it 'is not valid if the user has already liked the post' do
    like.save
    duplicate_like = Like.new(user:, post:)
    expect(duplicate_like).not_to be_valid
  end

  it 'updates the likes counter on like deletion' do
    like.save
    expect { like.destroy }.to change { post.reload.likes_counter }.by(-1)
  end
end
