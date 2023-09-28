class CommentsController < ApplicationController
  include ApplicationHelper
  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(comment_params)
    @post = Post.find(params[:comment][:post_id])
    if @comment.save
      @notification = new_notification(@post.user, @post.id,
                                       'comment')
      @notification.save
      respond_to do |format|
        format.turbo_stream { render :create, locals: { post: @post, comment: @comment } }
        format.html { redirect_to @post }
      end

    else

      format.html { render :new, status: :unprocessable_entity, locals: { comment: @comment } }
      format.turbo_stream { render :new, status: :unprocessable_entity, locals: { comment: @comment } }

    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    remove_notifications(@comment.post_id)
    return unless current_user.id == @comment.user_id

    @comment.destroy
    flash[:success] = 'Comment deleted'
    redirect_back(fallback_location: root_path)
  end

  def remove_notifications(comment_id)
    @notification = Notification.find_by(notice_id: comment_id)
    @notification.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
