class RemoveLikeFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :like, :string
  end
end
