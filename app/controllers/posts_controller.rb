class PostsController < ApplicationController
  include ApplicationHelper
  before_action :set_post, only: %i[show edit update destroy]

  # GET /posts or /posts.json
  def index
    @our_posts = current_user.friends_and_own_posts
    @posts = Post.all
    @users = User.all
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts or /posts.json
  def create
    # @post = Post.new(post_params)
    @post = current_user.posts.build(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    remove_notifications(@post)
    @post.destroy

    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_notifications(post)
    user = post.user
    user.notice_seen = true

    notifications = Notification.where(notice_id: post.id, notice_type: 'like-post')
    notifications.each { |n| n&.destroy }

    notifications = Notification.where(notice_id: post.id, notice_type: 'comment')
    notifications.each { |n| n&.destroy }

    # like_posts = Like.where(post_id: post.id)
    # like_posts.each do |like|
    #   like&.destroy
    # end
    comments = Comment.where(post_id: post.id)
    return unless comments.present?

    comments.each do |comment|
      # like_comments = Like.where(comment_id: comment.id)
      # like_comments.each do |like|
      #   like&.destroy
      # end

      notifications = Notification.where(notice_id: comment.id, notice_type: 'like-comment')
      notifications.each { |n| n&.destroy }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    if Post.find_by(id: params[:id]).nil?
      redirect_to root_url
    else
      @post = Post.find(params[:id])
    end
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:body, :user_id)
  end
end
