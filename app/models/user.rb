class User < ApplicationRecord
  has_many :items
  has_many :orders

  has_secure_password

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, require: true

  enum role: ['default', 'merchant', 'admin']

  def matching_passwords?

  end

  def self.merchants
    where(role: 1)
  end
  #
  #the following section is for the merchant show page
  #
  def self.top_consumer_states(merchant)
    User.joins(orders: [{order_items: :item}])
    .select('users.state, sum(order_items.order_quantity) as num_items')
    .group(:state)
    .where("items.user_id = #{merchant.id}")
    .order('sum(order_items.order_quantity) DESC')
    .limit(3)
  end

  def self.top_consumer_cities(merchant)
    User.joins(orders: [{order_items: :item}])
    .select('users.city, users.state, sum(order_items.order_quantity) as num_items')
    .where("items.user_id = #{merchant.id}")
    .group(:city, :state)
    .order('sum(order_items.order_quantity) DESC')
    .limit(3)
  end

  def self.top_consumer(merchant)
    User.joins(orders: [{order_items: :item}])
    .select('users.username, count(orders.id) as num_orders')
    .where("items.user_id = #{merchant.id}")
    .group(:username)
    .order('count(orders.id) DESC')
    .limit(3)
  end

  def self.top_spenders(merchant)
    User.joins(orders: [{order_items: :item}])
    .select('users.username, sum(order_items.order_price) as spent')
    .where("items.user_id = #{merchant.id}")
    .group(:username)
    .order('sum(order_items.order_price) DESC')
    .limit(3)
  end
#
#the following section is for the merchant index page
#
  def self.top_revenue
    joins(items: [{order_items: :order}])
    .select('users.username, sum(order_items.order_price) as total_revenue')
    .group('users.username')
    .order('sum(order_items.order_price) DESC')
    .limit(3)
  end

  def self.top_cities
    joins(:orders)
    .select('users.city, users.state, count(orders.id)as count_of_orders')
    .group('users.city, users.state')
    .order('count(orders.id) DESC')
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


end
