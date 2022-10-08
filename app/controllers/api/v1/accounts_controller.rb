class Api::V1::AccountsController < ApplicationController
  before_action :check_if_logged_in
  before_action :check_if_buyer

  def deposit
    if current_user.deposit_amount(deposit_params[:amount])
      render json: { balance: current_user.balance }
    else
      render_custom_error('Please enter a valid amount.')
    end
  end

  def reset
    current_user.update_attribute(:deposit, 0)
    render_ok
  end

  private
  def deposit_params
    params.permit(:amount)
  end
end
