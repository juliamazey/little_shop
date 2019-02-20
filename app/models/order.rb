class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :user

  enum status: ['pending', 'cancelled', 'shipped']

  def self.find_by_user(user_id)
    where(user_id: user_id)
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

  def fulfilled_items?
    order_items.all? do |order_item|
      order_item.fulfilled?
    end
  end

  def self.merchant_orders(merchant)
    joins(:items).where(status: 0, items: {user: merchant}).group(:id)
  end

  def self.cancelled?
    all.any? do |order|
      order.status == "cancelled"
    end
  end

end
