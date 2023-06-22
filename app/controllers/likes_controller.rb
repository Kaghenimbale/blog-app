class LikesController < ApplicationController
    def create
      # redirect_to :back
      @user = User.find(params[:user_id])
      @post = @user.posts.find(params[:post_id])
      @like = @post.likes.new
      @like = @user.comments.new(post_id: @post.id, author_id: @user.id)
  
      if @like.save
         redirect_to user_post_path(@user, @post)
      else 
        render 'new'
      end
    end
  
    def like_params
      params.require(:likes).permit(:user_id, :post_id)
    end
  end