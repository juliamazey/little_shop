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

  def self.items_in_stock
    Item.sum(:stock)
  end

  def self.percent_sold
    ((OrderItem.items_sold.to_f / self.items_in_stock) * 100).round(0)
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
