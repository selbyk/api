class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  after_filter :set_access_control_headers

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end

  def require_valid_api_key
    if params[:key]
      @api_user = User.find_by_api_key(params[:key])
    end
    head :unauthorized unless @api_user
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
