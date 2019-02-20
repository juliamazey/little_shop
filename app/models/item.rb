class Item < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

  def self.select_active
    where(active:true)
  end

  def average_fulfillment(incoming_orders)
    binding.pry
    orders = incoming_orders.all.where(status: "shipped")
    time_array = []
    orders.each do |order|
      time_array << order.updated_at - order.created_at
    end
    count = time_array.count
    if count > 0
      average_float = time_array.sum / count
      average_float = average_float / 86400
      average = average_float.to_i
    else
      average = 0
    end
  end

  def self.top_five(limit = 5)
     Item.select("items.*, sum(order_items.order_quantity) as items_qty")
     .joins(:order_items)
     .group(:id)
     .order('items_qty desc')
     .limit(limit)
  end


  def self.bottom_five(limit = 5)
     Item.select("items.*, sum(order_items.order_quantity) as items_qty")
     .joins(:order_items)
     .group(:id)
     .order('items_qty')
     .limit(limit)
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
    qty = stock - quantity
    self.update(stock: qty)
  end

  def self.restock
    all.each do |item|
      qty = item.order_items.first.order_quantity
      restock = item.stock + qty
      item.update(stock: restock)
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

  def self.total_sold
    joins(:order_items).pluck('sum(order_items.order_quantity)').first
  end

  def self.percentage_sold
    (total_sold.to_f / (total_sold + total_stock) * 100).round(0)
  end

  def self.total_stock
    self.sum(:stock)
  end

end
