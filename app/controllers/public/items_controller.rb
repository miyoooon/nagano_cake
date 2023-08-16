class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!, only: [:show]

  def index
    @items = Item.page(params[:page]).per(8)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new

    @cart_item_existing = current_customer.cart_items.find_by(item: @item)

  if @cart_item_existing
    # 個数を増やす
    @cart_item_existing.increment(:amount)
  end
  end





end
