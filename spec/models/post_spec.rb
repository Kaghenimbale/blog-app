require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to(:author).class_name('User').with_foreign_key(:author_id) }
    it { should have_many(:likes).with_foreign_key(:post_id) }
    it { should have_many(:comments).with_foreign_key(:post_id) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_numericality_of(:comments_counter).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).is_greater_than_or_equal_to(0) }
  end

  describe '#recent_comments' do
    let(:post) { create(:post) }
    let!(:comment1) { create(:comment, post: post, created_at: 2.days.ago) }
    let!(:comment2) { create(:comment, post: post, created_at: 1.day.ago) }
    let!(:comment3) { create(:comment, post: post, created_at: Time.now) }
    let!(:comment4) { create(:comment, post: post, created_at: 3.days.ago) }
    let!(:comment5) { create(:comment, post: post, created_at: 4.days.ago) }
    let!(:comment6) { create(:comment) } # Another comment not associated with the post

    it 'returns the five most recent comments of the post' do
      expect(post.recent_comments).to eq([comment3, comment2, comment1, comment4, comment5])
    end
  end
end
