require 'application_system_test_case'
require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_one = users(:one)
    @user_two = users(:two)
  end

  test 'should get index' do
    get users_url
    assert_response :success

    assert_select 'h1', 'Users'
    assert_select 'ul', count: 1
    assert_select 'li', count: User.count
  end

  test 'should display user information in index' do
    get root_url
    assert_response :success

    assert_select 'li', count: 2 do
      assert_select 'img', count: 2
      assert_select 'a', text: @user_one.name
      assert_select 'a', text: @user_two.name
      assert_select 'p', text: 'Number of posts: 1', count: 0
      assert_select 'p', text: 'Number of posts: 1', count: 0
    end
  end

  test 'should show user information in show' do
    get user_url(@user_one)
    assert_response :success

    assert_select 'p', text: @user_one.name, count: 1

    @user_one.recent_posts.each do |post|
      assert_select 'h2', text: "Title: #{post.title}", count: 2
      assert_select 'div', text: post.text, count: 2
      assert_select 'p', text: "comments: #{post.commentsCounter}", count: 0
      assert_select 'p', text: "likes: #{post.likesCounter}", count: 0
    end
  end
end
