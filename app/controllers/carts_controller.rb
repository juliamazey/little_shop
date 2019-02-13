class CartsController < ApplicationController

  def create

    flash[:success] = "Item added to cart!"
    redirect_to items_path
  end
end
