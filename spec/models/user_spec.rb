require 'rails_helper'

RSpec.describe User, type: :model do
  it 'name should be present' do
    user = User.new(name: '')
    expect(user).to_not be_valid
    expect(user.errors[:name]).to include("can't be blank")
  end

  it 'posts_counter should be greater than or equal to 0' do
    user = User.new(posts_counter: -1)
    expect(user).to_not be_valid
    expect(user.errors[:posts_counter]).to include('must be greater than or equal to 0')
  end

  describe '#recent_posts' do
    let(:user) { User.create(name: 'Test', posts_counter: 0) }
    let!(:post1) { user.posts.create(title: 'First', likes_counter: 0, comments_counter: 0, created_at: 1.day.ago) }
    let!(:post2) { user.posts.create(title: 'Second', likes_counter: 0, comments_counter: 0, created_at: 2.days.ago) }
    let!(:post3) { user.posts.create(title: 'Third', likes_counter: 0, comments_counter: 0, created_at: Time.now) }

    it 'returns 3 most recent posts' do
      recent_posts = user.recent_posts
      expect(recent_posts.size).to eq(3)
      expect(recent_posts).to eq([post3, post1, post2])
    end
  end
end
