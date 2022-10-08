class Api::V1::ProductsController < ApplicationController
  before_action :check_if_logged_in
  before_action :check_if_seller, except: [:list, :show]
  before_action :load_product, only: [:show, :update, :destroy]

  def list
    render json: Product.all, each_serializer: ProductSerializer
  end

  def index
    render json: product_scope.all, each_serializer: ProductSerializer
  end

  def create
    product = product_scope.new(product_params)
    if product.save
      render json: product, status: :created, serializer: ProductSerializer
    else
      render_error_response(product)
    end
  end

  def show
    render json: @product, serializer: ProductSerializer
  end

  def update
    @product.assign_attributes(product_params)
    if @product.save
      render json: @product, status: :ok, serializer: ProductSerializer
    else
      render_error_response(@product)
    end
  end

  def destroy
    if @product.destroy
      render_ok
    else
      render_error_response(@product)
    end
  end

  private
  def load_product
    @product = product_scope.find_by_id(params[:id])
    render_not_found unless @product
  end

  def product_scope
    params[:action] == 'show' ? Product : current_user.products
  end

  def product_params
    params.require(:product).permit(:name, :cost, :amount_available)
  end
end
