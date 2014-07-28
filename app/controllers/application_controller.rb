class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_valid_api_key
    head :bad_request unless params[:key] && User.find_by_api_key(params[:key])
  end

  def not_found
    fail ActionController::RoutingError, 'Not Found'
  end
end
