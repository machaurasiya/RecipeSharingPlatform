class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: exception.message || "You are not authorized to perform this task" }, status: :forbidden
  end


  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end
end
