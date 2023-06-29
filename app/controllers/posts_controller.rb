class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def create
    post = current_user.posts.new(post_params)
    @user = User.find(params[:user_id])
    @post = @user.posts.create(post_params)
    @post.save
    redirect_to user_posts_path(@user)
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.build
  end

  def post_params
    params.require(:post).permit(:title, :text, :comments_counter, :likes_counter)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to user_posts_path(current_user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end

