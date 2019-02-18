class Admin::MerchantsController < Admin::BaseController

  def show
    current_user = User.find(params[:format])
    # binding.pry
    if current_user.role == "default"
      redirect_to admin_user_path(current_user)
    else
      @merchant = current_user
    end
  end

  def downgrade
    @merchant = User.find(params[:format])
    @merchant.role = 0
    @merchant.items.each do |item|
      item.active = false
    end
    flash[:success] = "This user has been downgraded."
    redirect_to admin_user_path(@merchant)
  end
end
