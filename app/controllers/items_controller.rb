class ItemsController < ApplicationController

  def index
    @items = Item.select_active
  end

  def show
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.name = params[:item][:name]
    @item.description = params[:item][:description]
    @item.price = params[:item][:price]
    @item.stock = params[:item][:stock]
    if @item.save
      flash[:success] = "Item updated!"
      redirect_to merchant_dashboard_items_path
    end
  end

  def create
    @user = current_user
    @item = Item.create(item_params)
    @item.user_id = @user.id

    if @item.save
      flash[:success] = "Item saved!"
      redirect_to merchant_dashboard_items_path
    else
      flash[:failure] = "All non-image fields are required"
      redirect_to merchant_dashboard_item_new_path
    end
  end

  def edit
    @item = Item.find(params[:id])
  end


private

  def item_params
    if current_merchant? || current_admin?
      params.require(:item).permit(:price, :stock, :active, :description, :name, :user_id)
    end
  end

end
