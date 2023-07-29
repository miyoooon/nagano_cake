class Public::CartItemsController < ApplicationController
  def index
  end

  def create
    @cart_items = CartItem.new(cart_items_params)
    @cart_items.save
    redirect_to cart_items_path
  end

   private

  def cart_items_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
