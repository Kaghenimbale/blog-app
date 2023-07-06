class Api::V1::CommentsController < ApplicationController
  def index
    @comments = Post.find(params[:post_id]).comments.all
    render json: @comments
  end

  def create
    post = Post.find(params[:post_id])
    user = User.find_by(auth_key: request.headers['Auth-Key'])

    if user.present?
      comment = post.comments.build(author: user, text: comment_params[:text])

      if comment.save
        render json: comment, status: :created
      else
        render json: comment.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'Invalid Auth Key' }, status: :unauthorized
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
