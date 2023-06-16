require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'title should be present' do
    post = Post.new(title: '')
    expect(post).to_not be_valid
    expect(post.errors[:title]).to include("can't be blank")
  end

  it 'title should not be too long' do
    post = Post.new(title: 'a' * 251)
    expect(post).to_not be_valid
    expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
  end

  it 'comments_counter should be greater than or equal to 0' do
    post = Post.new(comments_counter: -1)
    expect(post).to_not be_valid
    expect(post.errors[:comments_counter]).to include('must be greater than or equal to 0')
  end

  it 'likes_counter should be greater than or equal to 0' do
    post = Post.new(likes_counter: -1)
    expect(post).to_not be_valid
    expect(post.errors[:likes_counter]).to include('must be greater than or equal to 0')
  end

  describe '#recent_comments' do
    let(:user) { User.create(name: 'Test', posts_counter: 0) }
    let(:user2) { User.create(name: 'Fuad', posts_counter: 0) }
    let(:post) { user.posts.create(title: 'Test', likes_counter: 0, comments_counter: 0) }
    let!(:comment1) { post.comments.create(text: 'First', author_id: user2.id, created_at: 1.day.ago) }
    let!(:comment2) { post.comments.create(text: 'Second', author_id: user2.id, created_at: 2.days.ago) }
    let!(:comment3) { post.comments.create(text: 'Third', author_id: user2.id, created_at: Time.now) }
    let!(:comment4) { post.comments.create(text: 'Fourth', author_id: user2.id, created_at: 3.days.ago) }
    let!(:comment5) { post.comments.create(text: 'Fifth', author_id: user2.id, created_at: 4.days.ago) }
    let!(:comment6) { post.comments.create(text: 'Sixth', author_id: user2.id, created_at: 5.days.ago) }

    it 'returns 5 most recent comments' do
      recent_comments = post.recent_comments
      expect(recent_comments.size).to eq(5)
      expect(recent_comments).to eq([comment3, comment1, comment2, comment4, comment5])
    end
  end

  describe '#update_post_counter' do
    let(:user) { User.create(name: 'Test', posts_counter: 0) }
    let(:user2) { User.create(name: 'Test', posts_counter: 1) }

    it "updates user's posts_counter after creating a post" do
      expect do
        user.posts.create(title: 'Test', likes_counter: 0, comments_counter: 0)
        user.reload
      end.to change(user, :posts_counter).by(1)
    end
  end
end
