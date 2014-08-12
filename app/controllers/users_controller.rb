class UsersController < ApplicationController
  before_filter :require_valid_api_key, only: [:update, :destroy]
  before_filter :find_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render :show, status: :created
    else
      respond_with_errors(@user)
    end
  end

  def update
    head :unauthorized unless @user == @api_user
    if @user.update(user_params)
      render :show
    else
      respond_with_errors(@user)
    end
  end

  def destroy
    head :unauthorized unless @user == @api_user
    @user.destroy
    head :no_content
  end

  private

  def find_user
    @user = User.find_by_username(params[:id]) || not_found
  end

  def user_params
    params.permit(:username, :email, :password)
  end
end
