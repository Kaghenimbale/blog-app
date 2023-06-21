class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :post, class_name: 'Post', foreign_key: :post_id

  after_save :comments_posts_counter

  def comments_posts_counter
    comments_counter = post.comments_counter || 0
    post.update(comments_counter: comments_counter + 1)
  end
end
