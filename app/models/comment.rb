class Comment < ApplicationRecord
  belongs_to :author , class_name: 'User', foreign_key: :author_id
  belongs_to :post, class_name: 'Post', foreign_key: :post_id

  after_save :comments_posts_counter

  private

  def comments_posts_counter
    post.update!(comments_counter: post.comments.count)
  end
end
