class CommentsController < ApplicationController
  load_and_authorize_resource


  def index
    @user = User.includes(:posts).find(params[:user_id])
    @post = @user.posts
    @comments = Comment.where(posts: @post)


    respond_to do |format|
      format.html
      format.json { render json: @comments }
    end
  end
  
  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @user.comments.new(text: comment_params[:text], post_id: @post.id, author_id: @user.id)

    if @comment.save
      redirect_to user_post_path(@user, @post)
    else
      render 'new'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to user_post_path(user_id: @comment.author_id, id: @comment.post_id)
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
