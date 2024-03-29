class PostsController < ApplicationController
  before_filter :require_valid_api_key, only: [:create, :destroy]

  def index
    page = params[:page] || 1

    @user = User.find_by_username(params[:user_id])
    not_found if params[:user_id] && @user.nil?

    @posts = @user ? @user.posts.page(page) : Post.page(page)
    @posts = @posts.order('created_at DESC')
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

  def destroy
    @user = User.find_by_username(params[:user_id]) || not_found
    head :unauthorized unless @user == @api_user

    @post = Post.find(params[:id])
    @post.destroy
    head :no_content
  end

  private

  def post_params
    params.permit(:content)
  end
end
