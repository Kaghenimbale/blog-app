require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    # Any setup code specific to UsersControllerTest
  end

  test 'should get index' do
    get users_index_url
    assert_response :success
  end

  test 'should get show' do
    get users_show_url
    assert_response :success
  end
end
