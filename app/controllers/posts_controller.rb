class PostsController < ApplicationController
  before_action :set_user
  before_action :set_post, only: [:show]

  def index
    @posts = @user.posts if @user
    @comments = @user.comments
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    @post = @user.posts.build(post_params)

    if @post.save
      redirect_to user_posts_path(@user), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def show
    @post = @user.posts.find_by(id: params[:id])
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = params[:id] == 'new' ? nil : @user.posts.find_by(id: params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text)

    @user = User.find_by_id(params[:user_id])
    @post = @user.posts.find_by_id(params[:id])

    # You might want to handle the case where @post is nil, for example:
    return unless @post.nil?

    flash[:alert] = 'Post not found'
    redirect_to user_posts_path(@user)
  end
end
