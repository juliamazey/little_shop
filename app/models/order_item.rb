class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item


  def self.biggest_orders
    select('order_id, sum(order_quantity)as total_quantity')
    .group(:order_id)
    .order('sum(order_quantity) DESC')
    .limit(3)
  end
end
