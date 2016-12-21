class OrdersController < ApplicationController
  respond_to :json

  def index
    user = User.find(params[:user_id])
    respond_with user.orders
  end
end
