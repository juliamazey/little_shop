class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items

  enum status: ['pending', 'cancelled', 'shipped']

  def self.find_by_user(user_id)
    where(users_id: user_id)
  end

  def total_items(order)
    # binding.pry

  end

  def grand_total

  end

end
