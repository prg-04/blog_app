require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(
      name: 'Tom Cruise',
      posts_counter: 0,
      photo: 'https://example.com/photo.jpg'
    )
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user = User.new(name: nil)
    expect(user).to_not be_valid
  end

  it 'is not valid with a name exceeding 255 characters' do
    user = User.new(name: 'A' * 256)
    expect(user).to_not be_valid
  end

  it 'is not valid with a negative posts_counter' do
    user = User.new(posts_counter: -1)
    expect(user).to_not be_valid
  end

  it 'returns the 3 most recent posts' do
    user = User.create(
      name: 'Tom Cruise',
      posts_counter: 0,
      photo: 'https://example.com/photo.jpg'
    )

    post1 = Post.create(author: user, title: 'Post 1', text: 'Text 1')
    post2 = Post.create(author: user, title: 'Post 2', text: 'Text 2')
    post3 = Post.create(author: user, title: 'Post 3', text: 'Text 3')
    post4 = Post.create(author: user, title: 'Post 4', text: 'Text 4')

    recent_posts = user.recent_posts

    expect(recent_posts).to include(post4)
    expect(recent_posts).to include(post3)
    expect(recent_posts).to include(post2)
    expect(recent_posts).to_not include(post1)
  end
end
