class Order < ApplicationRecord
  has_many :items, through: :order_items
  has_many :order_items
end
