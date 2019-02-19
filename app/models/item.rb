class Item < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items
  validates_presence_of :price, :name, :description, :stock

  def self.select_active
    where(active:true)
  end


  def average_fulfillment
  end


  def self.top_five
     Item.select("items.*, sum(order_items.order_quantity) as items_qty")
     .joins(:order_items)
     .group(:id)
     .order('items_qty desc')
     .limit(5)
  end

  def quantity_sold
    order_items.sum do |order_item|
      order_item.order_quantity
    end
  end

  def self.merchant_items(merchant)
    Item.where(user_id: merchant.id)
  end

  def change_active_status
    if active
      active = false
    else
      active = true
    end
  end

  def orders_count
    self.order_items.all.count
  end



end
