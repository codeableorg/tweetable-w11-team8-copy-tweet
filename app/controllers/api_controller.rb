class ApiController < ActionController::API
  include ActionController::HTTPAuthentication::Token::ControllerMethods

  def authenticate_token
    authenticate_with_http_token do |token, _options|
      User.find_by(token: token)
    end
  end
end