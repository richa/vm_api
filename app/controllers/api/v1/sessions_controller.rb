class Api::V1::SessionsController < ApplicationController
  before_action :check_if_logged_in, only: :destroy

  def create
    @user = User.find_by_username(params[:username])
    if token = @user && @user.verify_password(params[:password])
      render json: { token: token }, status: :ok
    else
      render_unauthorized
    end
  end
end
