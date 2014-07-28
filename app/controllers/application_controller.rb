class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def require_valid_api_key
    head :unauthorized unless params[:key] && User.find_by_api_key(params[:key])
  end

  def not_found
    fail ActionController::RoutingError, 'Not Found'
  end

  def respond_with_errors(invalid_model)
    render json: {
      errors: invalid_model.errors.full_messages
    }, status: :unprocessable_entity
  end
end
