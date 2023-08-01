class Public::HomesController < ApplicationController
  def top
    @items = Item.order(created_at: :desc)
  end

  def about
  end
end
