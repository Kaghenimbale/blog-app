class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :likes, foreign_key: :post_id, dependent: :destroy
  has_many :comments, foreign_key: :post_id, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0 }

  after_save :update_post_counter
<<<<<<< HEAD
  after_destroy :update_post_counter
=======
  after_destroy :update_posts_counter
>>>>>>> a4c84a864fedc26f26523768ea587419cde9afd0

  def recent_comments
    comments.includes(:author).order(created_at: :desc).limit(5)
  end

  def update_post_counter
    author.update(posts_counter: author.posts.count)
  end
end
