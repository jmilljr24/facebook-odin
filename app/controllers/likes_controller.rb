class LikesController < ApplicationController
  include ApplicationHelper

  before_action :find_post
  before_action :find_like, only: [:destroy]

  def create
    if already_liked?
      flash[:notice] = 'You already liked this post!'
    else
      @post.likes.create(user_id: current_user.id)
    end
    redirect_to post_path(@post)
  end

  def destroy
    if !already_liked?
      flash[:notice] = 'You have not liked this post yet.'
    else
      @like.destroy
      redirect_to post_path(@post)
    end
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_like
    @like = Like.find(params[:id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, post_id:
    params[:post_id]).exists?
  end
end
