class ApiController < ActionController::API
  include Pundit
  include ActionController::HttpAuthentication::Token::ControllerMethods
  
  before_action :authorized_token

  rescue_from Pundit::NoAuthorizedError do |e|
    unauthorized_response(e.message)
  end

  def current_user
    @current_user ||= authenticate_token
  end

  def authorized_token
    authenticate_token || unauthorized_response('Access denied')
  end

  def unauthorized_response(message)
    error = { unauthorized: message }
    render json: error, status: :unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, _options|
      User.find_by(token: token)
    end
  end
end
