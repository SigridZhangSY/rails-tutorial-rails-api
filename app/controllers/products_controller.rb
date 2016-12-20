class ProductsController < ApplicationController
  respond_to :json

  def show
    product = respond_with Product.find_by_id(params[:id])
    if product.nil?
      head 404
    else
      return product
    end
  end

  def index
    respond_with Product.all
  end

  def create
    # print product_params
    product = Product.new(product_params)
    product.save
    render json: product, status: 201, location: user_product_url(product)
  end

  private
    def product_params
      params.require(:product).permit(:title, :price, :published)
      print product_params
      # params["user_id"] = params[:user_id]
    end
end
