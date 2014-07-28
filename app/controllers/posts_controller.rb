class PostsController < ApplicationController
  before_filter :require_valid_api_key, only: [:create]

  def index
    @user = User.find_by_username(params[:user_id])
    @posts = @user ? @user.posts : Post.all
  end

  def create
    @user = User.find_by_username(params[:user_id]) || not_found
    head :unauthorized unless @user == @api_user

    @post = @user.posts.new(post_params)
    if @post.save
      render :show, status: :created
    else
      respond_with_errors(@post)
    end
  end

  private

  def post_params
    params.permit(:content)
  end
end