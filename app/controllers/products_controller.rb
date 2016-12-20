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
    product.save
    puts 'ssss'
    product_url = Hash[:user_id => product[:user_id], :id => product[:id]]
    render json: product, status: 201, location: user_product_url(product_url)
  end

  private
    def product_params
      params.require(:product).permit(:title, :price, :published)
    end
end
