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
    user = User.find(params[:user_id])
    product = user.product.build(product_params)

    if product.save
      puts 'ssss'
      product_url = Hash[:user_id => product[:user_id], :id => product[:id]]
      render json: product, status: 201, location: user_product_url(product_url)
    else
      render json: {errors: product.errors}, status: 400
    end
  end

  def update
    user = User.find(params[:user_id])
    product = user.product.find(params[:id])
    if product.update(product_params)
      render json: product, status: 200
    else
      render json: {errors: product.errors}, status: 400
    end
  end

  private
  def product_params
    params.require(:product).permit(:title, :price, :published)
  end
end
