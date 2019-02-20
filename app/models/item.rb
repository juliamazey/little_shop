class Item < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

  def self.select_active
    where(active:true)
  end

  def average_fulfillment
  end

  def self.top_items(limit = 5)
     Item.select("items.*, sum(order_items.order_quantity) as items_qty")
     .joins(:order_items)
     .group(:id)
     .order('items_qty desc')
     .limit(limit)
  end

  def self.items_in_stock(merchant)
    Item
    .joins(:order_items)
    .select("sum(order_items.order_quantity) as items_qty")
    .group(:id)
    .order('items_qty desc')
    .limit(limit)
    # Item.select('sum(items.stock) as total_stock')
    # .where(user_id: merchant.id)
    # .limit(1)
  end


  def quantity_sold
    order_items.sum do |order_item|
      order_item.order_quantity
    end
  end

  def enough?(item)
    item.stock > item.quantity_sold
  end

  def deducts_stock(quantity)
    stock - quantity
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

  def self.total_sold(merchant)
    joins(:order_items)
    .select('items.user_id, sum(order_items.order_quantity) as total_qty, count(items.id)')
    .group('items.user_id')
    .where("items.user_id = #{merchant.id}")[0].total_qty
  end

  def self.percentage_sold(merchant)
    (self.total_sold(merchant) / (total_sold(merchant) + total_stock(merchant)) * 100).round(0)
  end

  def self.total_stock(merchant)
    self.where("items.user_id = #{merchant.id}")
    .sum(:stock).to_f
  end

end
