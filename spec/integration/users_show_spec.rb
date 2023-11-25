require 'rails_helper'
require 'capybara/rspec'
require 'capybara/rails'

RSpec.describe 'users show page', type: :feature do
  let(:sample_user_data) do
    {
      name: 'Tom Cruise',
      posts_counter: 0,
      bio: 'actor',
      photo: 'https://example.com/tom.jpg'
    }
  end
  before :each do
    @user = User.create(sample_user_data)
  end

  it 'should let user to see the user\'s profile picture' do
    visit user_path(@user)
    expect(page).to have_css("img[src*='https://example.com/tom.jpg']")
  end

  it 'should let see the user\'s username' do
    visit user_path(@user)
    expect(page).to have_content(@user.name)
  end

  it 'should let see the number of posts the user has written' do
    visit user_path(@user)
    expect(page).to have_content(@user.posts_counter)
  end

  it 'should let see the user\'s bio' do
    visit user_path(@user)
    expect(page).to have_content(@user.bio)
  end

  it 'should let see the user\'s first 3 posts' do
    posts = [
      { title: 'MI1',
        text: 'Ethan Hunt' },
      { title: 'MI2',
        text: 'Chimera' },
      { title: 'MI3',
        text: 'Forget' },
      { title: 'MI4',
        text: 'Ghost Protocol' },
      { title: 'MI5',
        text: 'Rougue Nation' },
      { title: 'MI6',
        text: 'Fallout' }
    ]

    posts.each do |item|
      @user.posts.create(item)
    end
    visit user_path(@user)
    posts.first(3).each do |post|
      expect(page).to have_content(post[:title])
    end
  end

  it 'I can see a button that lets me view all of a user\'s posts' do
    visit user_path(@user)
    expect(page).to have_css('.button-container')
  end

  it 'should redirect to the post\'s show page upon clicking the post content' do
    post = Post.create(author: @user, title: 'MI7', text: 'Dead Reckoning')
    post.save
    visit user_path(@user)
    click_on 'Dead Reckoning'
    expect(page).to have_current_path(user_post_path(user_id: @user.id, id: post.id))
  end

  it 'When I click to see all posts, it redirects me to the user\'s post\'s index page' do
    visit user_path(@user)
    click_link 'See all post'
    expect(page).to have_current_path(user_posts_path(@user))
  end
end
