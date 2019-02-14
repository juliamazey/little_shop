class ItemsController < ApplicationController

  def index
    @items = Item.find_by(active: true)
  end

  def show
    @item = Item.find(params[:id])
  end

end
