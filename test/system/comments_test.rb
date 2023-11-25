require 'application_system_test_case'
require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one)
    @comment = comments(:one)
  end

  test 'should create comment' do
    assert_difference('Comment.count', 1) do
      post user_post_comments_path(@user, @post), params: { comment: { text: 'New comment' } }
    end

    assert_redirected_to user_post_path(@user, @post)
    follow_redirect!

    assert_select 'li', text: /New comment/, count: 1
  end
end
