require 'rails_helper'

RSpec.describe 'User show page', type: :system do
  let!(:user) do
    User.create(name: 'John', photo: 'https://example.com/profile.jpg', bio: 'Software Engineer')
    User.create(name: 'Daniel', photo: 'https://example.com/profile.jpg', bio: 'Electrical Engineer')
  end

  let!(:posts) do
    user.posts.create([
                        { text: 'First post', comments_counter: 2, likes_counter: 5 },
                        { text: 'Second post', comments_counter: 3, likes_counter: 7 },
                        { text: 'Third post', comments_counter: 2, likes_counter: 10 }
                      ])
  end

  it 'displays user information and posts' do
    visit user_path(user)
    expect(page).to have_content(user.name)
    expect(page).to have_content("Number of post: #{user.posts_counter}")

    expect(page).to have_content('Bio :')
    expect(page).to have_content(user.bio)
  end

  it 'displays user information and posts' do
    visit user_path(user)
    expect(page).to have_content('Daniel')
    expect(page).to have_content("Number of post: #{user.posts_counter}")

    expect(page).to have_content('Bio :')
    expect(page).to have_content('Electrical Engineer')
  end

  it 'displays user profile' do
    visit user_path(user)

    expect(page).to have_css('.user-profile img[src*="https://example.com/profile.jpg"]')
  end

  it 'displays user posts path' do
    visit user_path(user)

    expect(page).to have_link('See all posts', href: user_posts_path(user), class: 'all_posts')
  end

  it 'redirects to the user\'s post\'s index page when clicking on the "See all posts" button' do
    visit user_path(user)

    click_link('See all posts')

    expect(page).to have_current_path(user_posts_path(user))
  end
end