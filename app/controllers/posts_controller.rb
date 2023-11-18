class PostsController < ApplicationController
  def index
    @user = User.find_by_id(params[:user_id])
    @posts = @user.posts if @user
    @comments = @user.comments
  end

  def show
    @user = User.find_by_id(params[:user_id])
    @post = @user.posts.find_by_id(params[:id])

    # You might want to handle the case where @post is nil, for example:
    return unless @post.nil?

    flash[:alert] = 'Post not found'
    redirect_to user_posts_path(@user)
  end
end
