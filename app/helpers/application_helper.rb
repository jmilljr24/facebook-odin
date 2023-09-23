module ApplicationHelper
  def comment; end

  def friend_request_sent?(user)
    current_user.friend_sent.exists?(sent_to_id: user.id, status: false)
  end

  def friend_request_received?(user)
    current_user.friend_request.exists?(sent_by_id: user.id, status: false)
  end

  def possible_friend?(user)
    request_sent = current_user.friend_sent.exists?(sent_to_id: user.id)
    request_received = current_user.friend_request.exists?(sent_by_id: user.id)

    return true if request_sent != request_received
    return true if request_sent == request_received && request_sent == true
    return false if request_sent == request_received && request_sent == false
  end

  # Returns the new record created in notifications table
  def new_notification(user, notice_id, notice_type)
    notice = user.notifications.build(notice_id:,
                                      notice_type:)
    user.notice_seen = false
    user.save
    notice
  end

  # Receives the notification object as parameter along with a type
  # and returns a User record, Post record or a Comment record
  # depending on the type supplied
  def notification_find(notice, type)
    return User.find(notice.notice_id) if type == 'friendRequest'
    return Post.find(notice.notice_id) if type == 'comment'
    return Post.find(notice.notice_id) if type == 'like-post'
    return unless type == 'like-comment'

    comment = Comment.find(notice.notice_id)
    Post.find(comment.post_id)
  end
end
