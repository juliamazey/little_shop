class Item < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items
  validates_presence_of :name, :price, :stock, :description

  def self.select_active
    where(active:true)
  end

  def average_fulfillment(incoming_orders)
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

  def self.items_in_stock(limit = 5)
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
    qty
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
    if active?
      update(active: false)
    else
      update(active: true)
    end
  end

  def orders_count
    self.order_items.all.count
  end

  def self.total_sold(merchant)
  result =  joins(:order_items)
    .select('items.user_id, sum(order_items.order_quantity) as total_qty, count(items.id)')
    .group('items.user_id')
    .where("items.user_id = #{merchant.id}")[0]

    return result.total_qty unless result.nil?
    return 0
  end

  def self.percentage_sold(merchant)
    unless Item.all.count == 0
      (self.total_sold(merchant) / (total_sold(merchant) + total_stock(merchant)) * 100).round(0)
    end
  end

  def self.total_stock(merchant)
    self.where("items.user_id = #{merchant.id}")
    .sum(:stock).to_f
  end

end
