class PostsController < ApplicationController
  before_filter :find_user

  def index
    @posts = @user.posts
  end

  def create
    @post = @user.posts.new(post_params)

    if @post.save
      render :show, status: :created
    else
      respond_with_errors(@post)
    end
  end

  private

  def find_user
    @user = User.find_by_username(params[:user_id]) || not_found
  end
end