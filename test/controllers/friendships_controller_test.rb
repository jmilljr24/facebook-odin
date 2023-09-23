require "test_helper"

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    sign_in users(:one)

    get friendships_create_url(user_id: users(:one).id)
    assert_response :success
  end
end
