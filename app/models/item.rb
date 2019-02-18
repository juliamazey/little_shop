class Item < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

  def self.select_active
    where(active:true)
  end

  def self.merchant_items(merchant)
    Item.where(user_id: merchant.id)
  end

  def change_active_status
    if active
      active == false
    else
      active == false
      active == true
    end
  end

  def orders_count
    self.order_items.all.count
  end


end
