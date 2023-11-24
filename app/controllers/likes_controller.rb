class LikesController < ApplicationController
  before_action :set_user_and_post

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)

    if @like.save
      redirect_to user_post_path(@user, @post), notice: 'Post was successfully liked.'
    else
      redirect_to user_post_path(@user, @post), alert: 'Failed to like the post.'
    end
  end

  private

  def set_user_and_post
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
  end
end
