require 'rails_helper'
RSpec.describe 'User index page', type: :system do
  let!(:users) do
    User.create([{ name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.' },
                 { name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo.', bio: 'Teacher from England.' },
                 { name: 'Chris', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Developer from congo' }])
  end
  let!(:posts) do
    Post.create!([{ author: users[0], title: 'First Post', text: 'My first post' },
                  { author: users[1], title: 'Second Post', text: 'My Second post' },
                  { author: users[2], title: 'Third Post', text: 'My Third post' }])
  end
  describe 'User index' do
    it 'shows all users' do
      visit users_path
      users.each do |user|
        expect(page).to have_content(user.name)
      end
    end
    it 'shows the profile picture for each user' do
      visit users_path
      users.each do |user|
        expect(page).to have_css("img[src*='#{user.photo}']")
      end
    end
    it 'shows how many posts each user has written' do
      visit users_path
      users.each do |user|
        expect(page).to have_content(user.posts_counter)
      end
    end
    it 'user clicks on user name and goes to user page' do
      visit users_path
      click_on users[1].name
      expect(page).to have_content(users[1].bio)
    end
  end
end