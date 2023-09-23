require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    sign_in users(:one)
    get users_index_url
    assert_response :success
  end

  # test 'should get show' do
  #   sign_in users(:one)
  #   get users_show_url
  #   assert_response :success
  # end
end
