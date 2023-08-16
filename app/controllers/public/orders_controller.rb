class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!, only: [:new, :create, :show, :confirm, :index, :complete]

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    #オーダーアイテムの保存
    current_customer.cart_items.each do |cart_item|
      order_item = OrderItem.new
      order_item.order_id = @order.id
      order_item.item_id = cart_item.item_id
      order_item.amount = cart_item.amount
      order_item.price = (cart_item.item.price*@order.shipping).to_i
      order_item.save
    end
    clear_cart
    redirect_to complete_orders_path
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:address_number] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name+current_customer.last_name

    elsif params[:order][:address_number] == "1"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end

  @cart_items = CartItem.all

  @total = 0
  @cart_items.each do |cart_item|
  item_price = cart_item.item.price * 1.08
  subtotal = (item_price * cart_item.amount).to_i
  @total += subtotal
  @order.total_payment = @total
  end


  end


  def complete
  end

  def index
    @orders = current_customer.orders
  end

  def show
    order = Order.find(params[:id])
    unless order.customer_id == current_customer.id
      redirect_to orders_path
    end
    @order = Order.find(params[:id])
  end

  private

  def clear_cart
    current_customer.cart_items.destroy_all
  end

  def order_params
  params.require(:order).permit(:postal_code, :address, :name, :payment_status, :customer_id, :total_payment)
  end
end
