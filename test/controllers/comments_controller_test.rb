require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @comment = comments(:one)
  end

  test 'should get create' do
    sign_in users(:one)
    assert_difference('Comment.count') do
      post comments_url, params: { comment: { content: @comment.content, post_id: @post.id } }
    end
    assert_redirected_to post_url(Post.find_by(id: @post.id))
  end
end
