class LikesController < ApplicationController
  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @like = @post.likes.new(user: @user)

    if @like.save
      redirect_to user_post_path(user_id: @post.author, id: @post), notice: 'Liked!'
    else
      redirect_to user_post_path(user_id: @post.author, id: @post), notice: 'Like failed!'
    end
  end
end
