class ItemsController < ApplicationController

  def index
    @items = Item.select_active
    @top = Item.top_five
    @bottom = Item.bottom_five
  end

  def show
    @item = Item.find(params[:id])
    @orders = @item.orders
    @fulfill_time_avg = @item.average_fulfillment(@orders).to_s
  end

  def update
    @item = Item.find(params[:id])
    @item.name = params[:item][:name]
    @item.description = params[:item][:description]
    @item.price = params[:item][:price]
    @item.stock = params[:item][:stock]

    if @item.save && current_admin?
      flash[:success] = "Item updated!"
      redirect_to admin_dashboard_items_path(@item.user_id)
    elsif @item.save
      flash[:success] = "Item updated!"
      redirect_to merchant_dashboard_items_path
    elsif !@item.save && current_admin?
      flash[:failure] = "All non-image fields are required"
      redirect_to admin_edit_item_path(@item)
    else
      flash[:failure] = "All non-image fields are required"
      redirect_to merchant_edit_item_path(@item)
    end
  end

  def create
    if current_admin?
      @item = Item.create(item_params)
    else
      @user = current_user
      @item = Item.create(item_params)
      @item.user_id = @user.id
    end

    if @item.save && current_admin?
      flash[:success] = "Item saved!"
      redirect_to admin_dashboard_items_path(item_params[:user_id])
    elsif @item.save
      flash[:success] = "Item saved!"
      redirect_to merchant_dashboard_items_path
    elsif !@item.save && current_admin?
      flash[:failure] = "All non-image fields are required"
      redirect_to admin_item_new_path(item_params[:user_id])
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
