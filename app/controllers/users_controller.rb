class UsersController < ApplicationController
  before_filter :require_valid_api_key, only: [:update, :destroy]
  before_filter :find_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def create
    params.require(:user).permit(:username, :email, :password)
    @user = User.new(params[:user])
    
    if @user.save
      render :show
    else
      head :unprocessable_entity
    end
  end

  def update
    params.require(:user).permit(:username, :email, :password)

    if @user.update(params[:user])
      render :show
    else
      head :unprocessable_entity
    end
  end

  def destroy
    @user = User.find_by_username(params[:username]) || not_found
    @user.destroy
    head :no_content
  end

  private

  def find_user
    @user = User.find_by_username(params[:username]) || not_found
  end
end