require 'application_system_test_case'
require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post_one = posts(:one)
    @post_two = posts(:two)
  end

  test 'should get posts index' do
    get user_posts_path(@user)
    assert_response :success

    assert_select 'h4', text: 'Comments', count: 2
    assert_select 'li', count: 5 do
      assert_select 'a', text: @post_one.title
      assert_select 'a', text: @post_two.title
    end
  end

  test 'should show post details' do
    get user_post_path(@user, @post_one)
    assert_response :success

    assert_select 'p', text: 'comments: 0', count: 1
    assert_select 'p', text: 'likes: 0', count: 1
    assert_select 'p', text: @post_one.text, count: 0
    assert_select 'ul.block.border', count: 1
    assert_select 'li.block.w-100', count: 1
    assert_select 'div.flex.flex-col.border.items-start.min-h-52.overflow-y-scroll.p-4.w-100', count: 1
    assert_select 'a', text: 'Comments', count: 1
    assert_select 'div.border-t.pt-4', count: 2
  end

  test 'should show post details with comments' do
    comment_one = comments(:one)
    comment_two = comments(:two)

    get user_post_path(@user, @post_one)
    assert_response :success

    assert_select 'p', text: 'comments: 0', count: 1
    assert_select 'p', text: 'likes: 0', count: 1
    assert_select 'p', text: @post_one.text, count: 0
    assert_select 'ul.block.border', count: 1
    assert_select 'li.block.w-100', count: 1
    assert_select 'div.flex.flex-col.border.items-start.min-h-52.overflow-y-scroll.p-4.w-100', count: 1
    assert_select 'a', text: 'Comments', count: 1
    assert_select 'div.border-t.pt-4', count: 2
    assert_select 'li.pt-4', count: 0 do
      assert_select 'a', text: "#{comment_one.user.name}: #{comment_one.text}"
      assert_select 'a', text: "#{comment_two.user.name}: #{comment_two.text}"
    end
  end
end
