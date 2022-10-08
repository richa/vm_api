class Api::V1::PurchasesController < ApplicationController
  before_action :check_if_logged_in
  before_action :check_if_buyer
  before_action :load_product

  def create
    purchase = current_user.purchases.new(buy_params)
    if purchase.save
      render json: purchase, status: :created, serializer: PurchaseSerializer
    else
      render_error_response(purchase)
    end
  end

  private
  def load_product
    @product = Product.find_by(id: buy_params[:product_id])
    render_not_found unless @product
  end

  def buy_params
    params.permit(:product_id, :quantity)
  end
end
