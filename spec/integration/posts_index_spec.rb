require 'rails_helper'

RSpec.describe 'Post', type: :feature do
  before :each do
    @user = User.create(name: 'Tome Cruise', photo: 'https://example.com/tom.jpg',
                        bio: 'actor')
    @post = Post.create(author: @user, title: 'MI7', text: 'First Part')
  end

  it 'should let see the user\'s profile picture.' do
    visit user_posts_path(id: @user.id)
    expect(page).to have_css("img[src*='#{@user.photo}']")
  end

  it 'should let see the user\'s username.' do
    visit user_posts_path(id: @user.id)
    expect(page).to have_content(@user.name)
  end

  it 'should display the number of posts the user has written' do
    visit user_posts_path(id: @user.id)
    expect(page).to have_content(@user.posts_counter)
  end

  it 'should display a post\'s title' do
    visit user_posts_path(id: @user.id)
    expect(page).to have_content(@post.title)
  end

  it 'should let see some of the post\'s body.' do
    visit user_posts_path(id: @user.id)
    expect(page).to have_content(@post.text)
  end

  it 'should display the first comments on a post' do
    comment = Comment.create(author: @user, post: @post, text: 'This is a comment')
    comment.save
    visit user_post_path(user_id: @user.id, id: @post.id)
    expect(page).to have_content(comment.text)
  end

  it 'should let users see how many comments a post has' do
    comment = Comment.create(author: @user, post: @post, text: 'This is a comment')
    comment.save
    visit user_post_path(user_id: @user.id, id: @post.id)
    expect(page).to have_content(@post.comments_counter)
  end

  it 'should display how many likes a post has' do
    like = Like.create(user: @user, post: @post)
    like.save
    visit user_post_path(user_id: @user.id, id: @post.id)
    expect(page).to have_content(@post.likes_counter)
  end

  it 'should have a section for pagination if there are more posts than fit on the view' do
    visit user_posts_path(id: @user.id)
    expect(page).to have_css('.button-container')
  end

  it 'should redirects to that post\'s show page upon clicking the post content' do
    visit user_posts_path(id: @user.id)
    click_on @post.text.to_s
    expect(page).to have_current_path(user_post_path(user_id: @user.id, id: @post.id))
  end
end
