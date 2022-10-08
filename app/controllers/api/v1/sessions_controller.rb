class Api::V1::SessionsController < ApplicationController
  before_action :check_if_logged_in, except: [:create]

  def create
    @user = User.find_by_username(params[:username])
    if token = @user && @user.verify_password(params[:password])
      render json: {
        token: token,
        active_sessions: @user.auth_tokens.count
      }, status: :ok
    else
      render_unauthorized
    end
  end

  def destroy
    current_user_session.destroy
    render_ok
  end

  def destroy_all
    current_user.auth_tokens.destroy_all
    render_ok
  end
end
