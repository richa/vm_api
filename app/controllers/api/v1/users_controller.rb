class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      token = user.verify_password(user_params[:password])
      render json: { user: UserSerializer.new(user), token: token }, status: :created
    else
      render_error_response(user)
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
