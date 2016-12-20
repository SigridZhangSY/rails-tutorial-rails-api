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
end
