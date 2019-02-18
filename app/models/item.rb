class Item < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

  def self.select_active
    where(active:true)
  end

  def average_fulfillment
  end


  def self.top_five
     Item.all.select("items.*, sum(order_items.order_quantity) as items_qty")
     .joins(:order_items)
     .group(:id, :item_id)
     .order('items_qty desc')
     .limit(5)
  end

  def quantity_sold
    order_items.sum do |order_item|
      order_item.order_quantity
    end
  end
end
