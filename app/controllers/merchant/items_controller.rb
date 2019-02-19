class Merchant::ItemsController < Merchant::BaseController
  def index
    @items = Item.merchant_items(current_user)
    # @status = Item.change_active_status
    # flash[:success] = "This item is no longer for sale."
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end


  def edit
    @item = Item.find(params[:id])
    @item.change_active_status
    redirect_to merchant_index_items_path
  end


end
