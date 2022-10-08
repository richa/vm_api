class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created, serializer: UserSerializer
    else
      render_error_response(user)
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
