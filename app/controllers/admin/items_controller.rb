class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create, :index, :show, :edit, :update]

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(current_admin.id)
    else
      render :new
    end
  end

  def index
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  def item_params
    params.require(:item).permit(:name, :introduction, :image, :price)
  end
end
