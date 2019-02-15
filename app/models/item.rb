class Item < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

  def average_fulfillment
    binding.pry
    Item.select("items.*, avg(order_items.updated_at - order_items.created_at) as average_fulfillment").joins(:orders).group(:item_id).where(item_id: @item_id)
  end
end
