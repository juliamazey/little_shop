class Merchant::ItemsController < Merchant::BaseController
  def index
    @items = Item.merchant_items(current_user)
    # @status = Item.change_active_status
    # flash[:success] = "This item is no longer for sale."
  end

  def show
    @item = Item.find(params[:format])
  end

  def new
    @item = Item.new
    # binding.pry
  end


  def edit
    @item = Item.find(params[:id])
    @item.change_active_status
    redirect_to merchant_dashboard_items_path
  end


  def destroy
    @item = Item.find(params[:format])
    @item.delete
    redirect_to merchant_dashboard_items_path
  end


end
