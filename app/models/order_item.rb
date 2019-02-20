class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item


  def self.biggest_orders
    select('order_id, sum(order_quantity)as total_quantity')
    .group(:order_id)
    .order('sum(order_quantity) DESC')
    .limit(3)
  end

  def self.fast_merch
    OrderItem.joins(item: :user)
    .select('users.username, sum(order_items.updated_at - order_items.created_at)as fulfillment_time')
    .group('users.username')
    .order('sum(order_items.updated_at - order_items.created_at) ASC')
    .limit(3)
  end

  def self.slow_merch
    OrderItem.joins(item: :user)
    .select('users.username, sum(order_items.updated_at - order_items.created_at)as fulfillment_time')
    .group('users.username')
    .order('sum(order_items.updated_at - order_items.created_at) DESC')
    .limit(3)
  end

  def self.items_sold
    OrderItem.joins(item: :user)
    .sum(:order_quantity)
  end



  def top_user_by(type)
    items.joins(order_items: [{order: :user}])
    .select("users.username, count(distinct orders.id) as quantity")
    .where(order_items: {fulfilled: 1}, enabled: :enabled)
    .order("quantity desc")
    .group(:username)
    .limit(1)
  end
end
