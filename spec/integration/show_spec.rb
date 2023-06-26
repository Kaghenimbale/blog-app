require 'rails_helper'

RSpec.describe 'User show page', type: :system do
  let!(:user) do
    User.create(name: 'John', photo: 'https://example.com/profile.jpg', bio: 'Software Engineer')
  end

  let!(:posts) do
    user.posts.create([
                        { text: 'First post', comments_counter: 2, likes_counter: 5 },
                        { text: 'Second post', comments_counter: 3, likes_counter: 7 }
                      ])
  end

  it 'displays user information and posts' do
    visit user_path(user)
    expect(page).to have_content('John')
    expect(page).to have_content("Number of post: #{user.posts_counter}")

    expect(page).to have_content('Bio :')
    expect(page).to have_content('Software Engineer')
  end

  it 'displays user profile' do
    visit user_path(user)

    expect(page).to have_css('.user-profile img[src*="https://example.com/profile.jpg"]')
  end

  it 'displays user posts path' do
    visit user_path(user)

    expect(page).to have_link('See all posts', href: user_posts_path(user), class: 'all_posts')
  end
end
