require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:posts).with_foreign_key(:author_id) }
    it { should have_many(:likes).with_foreign_key(:author_id) }
    it { should have_many(:comments).with_foreign_key(:author_id) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:posts_counter) }
    it { should validate_numericality_of(:posts_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe '#recent_posts' do
    let(:user) { create(:user) }
    let!(:post1) { create(:post, author: user, created_at: 2.days.ago) }
    let!(:post2) { create(:post, author: user, created_at: 1.day.ago) }
    let!(:post3) { create(:post, author: user, created_at: Time.now) }
    let!(:post4) { create(:post, author: user, created_at: 3.days.ago) }

    it 'returns the three most recent posts of the user' do
      expect(user.recent_posts).to eq([post3, post2, post1])
    end
  end
end
