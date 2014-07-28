class ValidationsController < ApplicationController
  def create
    params.permit(:username, :password)

    user = User.find_by_username(params[:username]) || not_found
    if user.authenticate(params[:password])
      render json: { key: user.api_key }
    else
      head :unauthorized
    end
  end
end