class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_by, through: :likes, source: :user
end
