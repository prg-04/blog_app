require "application_system_test_case"
require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one)
  end

  test "should create like" do
    assert_difference('@post.likesCounter', 0) do
      post user_post_likes_path(@user, @post)
    end

    @post.reload

    assert_redirected_to user_post_path(@user, @post)
    follow_redirect!

    assert_select 'p', text: "likes: #{@post.likesCounter}", count: 1
  end
end
