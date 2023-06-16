require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:author).class_name('User').with_foreign_key(:author_id) }
    it { should belong_to(:post).class_name('Post').with_foreign_key(:post_id) }
  end

  describe 'callbacks' do
    let(:post) { create(:post) }
    let(:user) { create(:user) }
    let!(:comment) { build(:comment, author: user, post: post) }

    it 'updates the comments_counter of the associated post after saving' do
      expect { comment.save }.to change { post.reload.comments_counter }.by(1)
    end
  end
end
