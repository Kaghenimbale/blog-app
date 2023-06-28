require 'rails_helper'

RSpec.describe 'Post index page', type: :system do
  let!(:users) do
    User.create([{ name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.' },
                 { name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from England.' },
                 { name: 'Chris', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Front end developer.' }])
  end
  let!(:posts) do
    Post.create!([{ author: users[0], title: 'First Post', text: 'My first post' },
                  { author: users[1], title: 'Second Post', text: 'My Second post' },
                  { author: users[2], title: 'Third Post', text: 'My Third post' }])
  end

  describe 'Post index' do
    it 'shows user profile picture' do
      visit user_posts_path(users[0])
      expect(page).to have_css('img[alt="user_profile"]')
    end
    it 'shows user name' do
      visit user_posts_path(users[0])
      expect(page).to have_content(users[0].name)
    end

    it 'shows posts count' do
      visit user_posts_path(users[0])
      expect(page).to have_content(users[0].posts_counter)
    end

    it 'shows a post title' do
      visit user_posts_path(users[0])
      expect(page).to have_content(posts[0].text)
    end

    it 'shows some of a post body' do
      visit user_posts_path(users[0])
      expect(page).to have_content(posts[0].text)
    end

    it 'shows the first comment on a post' do
      Comment.create!(author: users[0], post: posts[0], text: 'niceeee')
      visit user_posts_path(users[0])
      expect(page).to have_content(posts[0].comments[0].text)
    end

    it 'shows how many comments a post has' do
      Comment.create!(author: users[0], post: posts[0], text: 'niceeee')
      Comment.create!(author: users[1], post: posts[0], text: 'amazing')
      visit user_posts_path(users[0])
      expect(page).to have_content(posts[0].comments_counter)
    end
    it 'shows how many likes a post has' do
      Like.create!(author: users[0], post: posts[0])
      visit user_posts_path(users[0])
      expect(page).to have_content(posts[0].likes_counter)
    end
    it 'shows pagination section' do
      visit user_posts_path(users[0])
      expect(page).to have_content('Pagination')
    end
    it 'When click on a post, it redirects to that post show page' do
      visit user_posts_path(users[0])
      click_on 'My first post'
      expect(page).to have_content('My first post')
    end
  end
end
