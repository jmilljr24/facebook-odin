class AddCommentRefToLikes < ActiveRecord::Migration[7.0]
  def change
    add_reference :likes, :comment, foreign_key: true
  end
end
