class Admin::MerchantsController < Admin::BaseController

  def index
    @merchants = User.merchants
  end

  def show
    current_user = User.find(params[:format])
    if current_user.role == "default"
      redirect_to admin_user_path(current_user)
    else
      @merchant = current_user
    end
  end

  def downgrade
    @merchant = User.find(params[:format])
    @merchant.items.each do |item|
      item.active = false
    end
    @merchant.update(role: 0)
    #
    flash[:success] = "This user has been downgraded."
    redirect_to admin_user_path(@merchant)
  end
end
