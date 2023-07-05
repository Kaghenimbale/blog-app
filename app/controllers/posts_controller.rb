class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end
  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
  end
  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.build
  end
end
