class ItemsController < ApplicationController

  def index
    @items = Item.select_active
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
  end




private

  def item_params
    params.require(:item).permit(:price, :stock, :active, :description, :name)
  end

end
