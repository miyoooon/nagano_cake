class Public::CartItemsController < ApplicationController
   before_action :authenticate_customer!, only: [:index, :create, :destroy, :destroy_all, :update]

  def index
    @cart_items = CartItem.all
    @cart_item = CartItem.new
  end

  def create
    @cart_item = CartItem.new(cart_items_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save!

    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    CartItem.destroy_all
    redirect_to cart_items_path
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.customer_id = current_customer.id
    @cart_item.update(cart_items_params)
    redirect_to cart_items_path
  end

   private

  def cart_items_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end

end
