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
    order = user.orders.build(order_params)
    order.save
    order_url = Hash[:user_id => order[:user_id], :id => order[:id]]
    render json: order, status: 201, location: user_order_url(order_url)
  end

  private

  def order_params
    params.require(:order).permit(:total, :user_id, :product_ids => [])
  end
end
