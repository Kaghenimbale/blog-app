class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :likes, foreign_key: :post_id
  has_many :comments, foreign_key: :post_id

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0 }

  after_save :update_post_counter

  def recent_comments
    comments.includes(:author).order(created_at: :desc).limit(5)
  end

  def update_post_counter
    posts_counter = author.posts_counter || 0
    author.update(posts_counter: posts_counter + 1)
  end
end
