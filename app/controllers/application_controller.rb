class ApplicationController < ActionController::API
  def render_error_response(obj)
    render json: { errors: obj.errors }, status: :unprocessable_entity
  end

  def render_unauthorized
    render json: { errors: { base: 'Unauthorized' } }, status: :unauthorized
  end

  def render_ok
     render json: {}, status: :ok
  end

  def current_user
    @current_user ||= AuthToken.where.not(token: nil).find_by_token(bearer_token)&.user
  end

  private
  def check_if_logged_in
    render_unauthorized unless current_user
  end

  def bearer_token
    pattern = /^Bearer /
    header  = request.headers['Authorization']
    header.gsub(pattern, '') if header && header.match(pattern)
  end
end
