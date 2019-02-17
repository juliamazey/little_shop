class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items

  enum status: ['pending', 'cancelled', 'shipped']

  def self.find_by_user(user_id)
    where(users_id: user_id)
  end

  def total_items
    #might move this to Order Item model
    # joins(:order_items).select("order_items.quantity").where("order.id =?, 142")
    order_items.sum {|order_item| order_item.order_quantity}
  end

  def grand_total
    #might move this to Order Item model
    order_items.sum {|order_item| order_item.order_price}
  end


end
