# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

10.times do |_i|
  email = Faker::Internet.email
  encrypted_password = Devise.friendly_token[0, 20]
  User.create!(
    email:,
    password: encrypted_password
  )
end
@user = User.all

@user.each do |u|
  u.posts.create!(
    body: Faker::Lorem.paragraph
  )
end
@posts = Post.all

10.times do
  post = @posts.sample
  Comment.create!(
    content: Faker::Lorem.paragraph,
    user_id: rand(1..10),
    post_id: post.id
  )
end

3.times do
  post = @posts.sample
  Like.create!(
    user_id: rand(1..10),
    post_id: post.id
  )
end

@comments = Comment.all

3.times do
  comment = @comments.sample
  Like.create!(
    user_id: rand(1..10),
    comment_id: comment.id
  )
end
