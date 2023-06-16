require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#update_comment_counter' do
    let(:user) { User.create(name: 'Test', posts_counter: 0) }
    let(:post) { user.posts.create(title: 'Test', likes_counter: 0, comments_counter: 0) }
    let(:post2) { user.posts.create(title: 'Test', likes_counter: 0, comments_counter: 1) }

    it "updates post's comments_counter after creating a comment" do
      expect do
        post.comments.create(text: 'Test', author_id: user.id)
        post.reload
      end.to change(post, :comments_counter).by(1)
    end
  end
end
