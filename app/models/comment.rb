class Comment < ApplicationRecord
  belongs_to :author , class_name: 'User'
  belongs_to :post

  after_save :comments_posts_counter

  private

  def comments_posts_counter
    post.increment!(:likes_counter)
  end
end
