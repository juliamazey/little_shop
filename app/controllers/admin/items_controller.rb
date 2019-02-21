class Admin::ItemsController < Admin::BaseController

  def index
    @merchants = User.merchants
    @items = Item.where(user_id: params[:format])
    @merchant = User.where(id: params[:format])
    render file: "app/views/admin/merchants/index.html.erb"
  end

  def new
    @item = Item.new
    @merchant = User.where(id: params[:format])
  end

  def edit
    # binding.pry
    @item = Item.find(params[:format])
  end

  def destroy
    @item = Item.find(params[:format])
    @merchant = User.find(@item.user_id)
    @item.delete
    redirect_to admin_dashboard_items_path(@merchant)
  end
end
