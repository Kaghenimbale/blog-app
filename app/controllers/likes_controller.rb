class LikesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @like = @user.likes.new(post_id: @post.id, author_id: @user.id)

    redirect_to user_post_path(@user, @post)
    return if @like.save

    render 'new'
  end

  private

  def like_params
    params.require(:like).permit(:user_id)
  end
end
