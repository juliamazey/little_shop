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
  end


end
