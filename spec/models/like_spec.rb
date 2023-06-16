require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '#update_like_counter' do
    let(:user) { User.create(name: 'Test', posts_counter: 0) }
    let(:post) { user.posts.create(title: 'Test', likes_counter: 0, comments_counter: 0) }
    let(:post2) { user.posts.create(title: 'Test', likes_counter: 1, comments_counter: 0) }

    it "updates post's likes_counter after creating a like" do
      expect do
        post.likes.create(author_id: user.id)
        post.reload
      end.to change(post, :likes_counter).by(1)
    end

    it "updates post's likes_counter after destroying a like" do
      like = post2.likes.create(author_id: user.id)
      expect do
        like.destroy
        post2.reload
      end.to change(post2, :likes_counter).by(-1)
    end
  end
end
