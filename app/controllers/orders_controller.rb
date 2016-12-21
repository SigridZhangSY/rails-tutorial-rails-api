class OrdersController < ApplicationController
  respond_to :json

  def index
    user = User.find(params[:user_id])
    respond_with user.orders
  end

  def show
    user = User.find(params[:user_id])
    respond_with user.orders.find(params[:id])
  end

  def create
    user = User.find(params[:user_id])
    order = user.orders.build
    order.build_placements_with_product_ids_and_quantities(params[:order][:product_ids_and_quantities])
    puts 'ddd'
    puts order.total
    if order.save
      # order.reload
      order_url = Hash[:user_id => order[:user_id], :id => order[:id]]
      render json: order, status: 201, location: user_order_url(order_url)
    else
      render json: { errors: order.errors }, status: 400
    end
  end
end
