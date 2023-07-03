require 'rails_helper'

RSpec.describe 'Post show page', type: :system do
  let!(:users) do
    User.create([{ name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.' },
                 { name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from England.' },
                 { name: 'Dan', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Analyst from Texas.' },
                 { name: 'Chris', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Web Developer.' }])
  end
  let!(:posts) do
    Post.create!([{ author: users[0], title: 'First Post', text: 'My first post' },
                  { author: users[1], title: 'Second Post', text: 'My Second post' },
                  { author: users[2], title: 'Third Post', text: 'My Third post' },
                  { author: users[3], title: 'Fourth Post', text: 'My Fourth post' }])
  end

  describe 'Post show' do
    it 'shows who wrote the post' do
      visit user_post_path(users[0], posts[0])
      expect(page).to have_content(posts[0].author.name)
    end

    it 'shows how many comments a post has' do
      Comment.create!(author: users[0], post: posts[0], text: 'It was really nice to meet you')
      Comment.create!(author: users[1], post: posts[0], text: 'It was really nice to meet you')
      Comment.create!(author: users[2], post: posts[0], text: 'It was really nice to meet you')
      visit user_post_path(users[0], posts[0])
      expect(page).to have_content(posts[0].comments_counter)
    end
    it 'shows how many likes a post has' do
      Like.create!(author: users[0], post: posts[0])
      Like.create!(author: users[1], post: posts[0])
      Like.create!(author: users[2], post: posts[0])
      Like.create!(author: users[3], post: posts[0])
      visit user_post_path(users[0], posts[0])
      expect(page).to have_content(posts[0].likes_counter)
    end

    it 'shows the post body' do
      visit user_post_path(users[0], posts[0])
      expect(page).to have_content(posts[0].text)
    end

    it 'shows the username of each commentor' do
      Comment.create!(author: users[0], post: posts[0], text: 'It was really nice to meet you')
      visit user_post_path(users[0], posts[0])

      posts[0].comments.each do |comment|
        expect(page).to have_content(comment.author.name)
      end
    end

    it 'shows a post title' do
      visit user_posts_path(users[0])
      expect(page).to have_content(posts[0].text)
    end

    it 'shows the comment each commentor left' do
      Comment.create!(author: users[0], post: posts[0], text: 'It was really nice to meet you')
      Comment.create!(author: users[2], post: posts[0], text: 'good')
      visit user_post_path(users[0], posts[0])

      posts[0].comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end
  end
end