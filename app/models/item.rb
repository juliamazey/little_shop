class Item < ApplicationRecord
  belongs_to :user
  has_many :orders, through: :order_items

end
