class Admin::MerchantsController < ApplicationController
  def show
    @merchant = User.find(params[:format])
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
