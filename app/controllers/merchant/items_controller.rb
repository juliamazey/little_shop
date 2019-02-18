class Merchant::ItemsController < Merchant::BaseController

  def index
    @items = current_user.items
  end

end
