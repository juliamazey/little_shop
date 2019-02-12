class ItemsController < ApplicationController

  def index
    @items = Item.where(active: true)
  end

end
