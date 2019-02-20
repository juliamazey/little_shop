class User < ApplicationRecord
  has_many :items
  has_many :orders

  has_secure_password
  
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, if: :password

  enum role: ['default', 'merchant', 'admin']

  def matching_passwords?

  end

  def self.merchants
    where(role: 1)
  end

  def self.top_consumers(current_user)
    joins(orders: [{order_items: :item}])
    .select('users.state, sum(order_items.order_quantity) as total_sold')
    .where("items.user_id = #{current_user.id}")
    .group('users.state')
    .order('sum(order_items.order_quantity) DESC')
    .limit(3)
  end

  def self.top_revenue
    joins(items: [{order_items: :order}])
    .select('users.username, sum(order_items.order_price) as total_revenue')
    .group('users.username')
    .order('sum(order_items.order_price) DESC')
    .limit(3)
  end

  def self.top_states
    joins(:orders)
    .select('users.state, count(orders.id)as count_of_orders')
    .group('users.state')
    .order('count(orders.id) DESC')
    .limit(3)
  end
#select users.state, count(order_items.order_quantity)as count
#from users
#inner join Orders on users.id = Orders.user_id
#inner join Order_Items on orders.id = Order_items.order_id

  def self.top_cities
    joins(:orders)
    .select('users.city, users.state, count(orders.id)as count_of_orders')
    .group('users.city, users.state')
    .order('count(orders.id) DESC')
    .limit(3)
  end

end
