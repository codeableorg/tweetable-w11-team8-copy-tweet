class Api::SessionsController < ApiController
  skip_before_action :authorized_token, only: :create  

  def create
    user = User.find_by(email: params[:user][:email])
    if user&.valid_password?(params[:user][:password])
      user.regenerate_token
      render json: { token: user.token }
    else
      unauthorized_response('Incorrect email or password')
    end
  end

  def destroy
    current_user.invalidate_token
    head :no_content
  end
end
