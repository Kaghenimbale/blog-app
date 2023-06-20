require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    # Any setup code specific to PostsControllerTest
  end

  test 'should get index' do
    get posts_index_url
    assert_response :success
  end

  test 'should get show' do
    get posts_show_url
    assert_response :success
  end
end
