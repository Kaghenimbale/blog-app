class PostsController < ApplicationController
  load_and_authorize_resource


  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts


    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def create
    post = current_user.posts.new(post_params)

    if post.save
      redirect_to user_posts_path, notice: 'Post created successfully!!'
    else
      flash.now[:alert] = 'Unable to create a post'
      render :new
    end
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.build
  end

  def destroy
    @post = Post.find(params[:id])
    @post.comments.destroy_all if @post.comments.exists?
    @post.likes.destroy_all if @post.likes.exists?
    @post.destroy
    redirect_to user_posts_path(user_id: current_user.id)
  end

  def post_params
    params.require(:post).permit(:title, :text, :comments_counter, :likes_counter)
  end
end
