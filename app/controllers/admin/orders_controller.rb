class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!, only: [:show]

  def show
    @order = Order.find(params[:id])
    @orders = Order.all
  end
end
