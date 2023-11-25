require 'rails_helper'
describe 'Post show', type: :feature do
  before(:each) do
    @first_user = User.create(name: 'Tom Cruise', photo: 'https://example.com/tom.jpg',
                              bio: 'actor, mission impossible')
    @second_user = User.create(name: 'Mel Gibson', photo: 'https://example.com/gibson.jpg', bio: 'actor, braveheart')
    @post = Post.create(author: @first_user, title: 'MI7', text: 'Dead Reckoning first part released')
    @first_comment = Comment.create(author: @second_user, post: @post, text: 'Good movie')
    @second_comment = Comment.create(author: @first_user, post: @post, text: 'Thank you')
    @third_comment = Comment.create(author: @second_user, post: @post, text: 'Welcome')
    @first_like = Like.create(post: @post, user: @first_user)
    @second_like = Like.create(post: @post, user: @second_user)
    visit user_posts_path(@first_user, @post)
  end

  it 'should let users see the post\'s title' do
    expect(page).to have_content(@post.title)
  end
  it 'should display who wrote the post' do
    expect(page).to have_content(@first_user.name)
  end
  it 'should display how many comments it has' do
    expect(page).to have_content(@post.comments_counter)
  end
  it 'should display how many likes it has' do
    expect(page).to have_content(@post.likes_counter)
  end
  it 'should display see the post body' do
    expect(page).to have_content(@post.text)
  end
  it 'should display the usernames of each commentor' do
    expect(page).to have_content(@first_comment.author.name)
    expect(page).to have_content(@second_comment.author.name)
    expect(page).to have_content(@third_comment.author.name)
  end
  it 'should display the comment each commentor left' do
    expect(page).to have_content(@first_comment.text)
    expect(page).to have_content(@second_comment.text)
    expect(page).to have_content(@third_comment.text)
  end
end
