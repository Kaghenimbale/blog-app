require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it { should belong_to(:author).class_name('User').with_foreign_key(:author_id) }
    it { should belong_to(:post).class_name('Post').with_foreign_key(:post_id) }
  end

  describe 'callbacks' do
    let(:post) { create(:post) }
    let(:user) { create(:user) }
    let!(:like) { build(:like, author: user, post: post) }

    it 'updates the likes_counter of the associated post after saving' do
      expect { like.save }.to change { post.reload.likes_counter }.by(1)
    end
  end
end
