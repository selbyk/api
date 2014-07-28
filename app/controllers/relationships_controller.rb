class RelationshipsController < ApplicationController
  before_filter :require_valid_api_key, only: [:create, :destroy]
  before_filter :find_user

  def create
    requested_user = User.find_by_username(params[:username]) || not_found
    head :unauthorized unless @user == @api_user    

    @user.follow! requested_user
    head :created
  end

  def destroy
    requested_user = User.find_by_username(params[:username]) || not_found
    head :unauthorized unless @user == @api_user    

    @user.unfollow! requested_user
    head :no_content
  end

  private

  def find_user
    @user = User.find_by_username(params[:user_id]) || not_found
  end
end