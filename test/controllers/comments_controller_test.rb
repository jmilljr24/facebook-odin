require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @comment = comments(:one)
  end

  test 'should get new' do
    sign_in users(:one)
    post_id = @post.id
    get new_comment_url, params: { post: @post }
    assert_response :success
  end

  test 'should get create' do
    sign_in users(:one)
    assert_difference('Comment.count') do
      post comments_url, params: { post: @post, comment: @comment }
    end
    assert_redirected_to comment_url(Comment.last)
  end
end
