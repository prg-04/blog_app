class LikesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @like = Like.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @like = @post.likes.build(like_params)
    @like.user = current_user

    if @like.save
      redirect_to user_post_path(@user, @post), notice: 'Post was successfully liked.'
    else
      render :new
    end
  end

  private

  def like_params
    params.require(:like).permit(:post_id, :user_id)
  end
end
