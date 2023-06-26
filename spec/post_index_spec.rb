require 'rails_helper'

RSpec.describe 'User post index page', type: :system do
  let!(:user) do
    User.create(name: 'John', photo: 'https://example.com/profile.jpg')
  end

  let!(:posts) do
    user.posts.create([
      { text: 'First post', comments_counter: 2, likes_counter: 5 },
      { text: 'Second post', comments_counter: 3, likes_counter: 7 }
    ])
  end

  it 'displays user information and posts' do
    visit user_posts_path(user)

    expect(page).to have_button('Pagination')
  end

  it 'redirects to post show page when a post is clicked' do
    visit user_posts_path(user)
    expect(page).to have_css('.post-show')
    expect(page).to have_content('John')
    expect(page).to have_content("Number of post: #{user.posts_counter}")
  end
end
