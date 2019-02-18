class Item < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

  def self.select_active
    where(active:true)
  end

  def average_fulfillment
  end
end
