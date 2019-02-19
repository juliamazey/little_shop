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

  def self.top_consumers(current_user)
    joins(orders: [{order_items: :item}])
    .select('users.state, sum(order_items.order_quantity) as total_sold')
    .where("items.user_id = #{current_user.id}")
    .group('users.state')
    .order('sum(order_items.order_quantity) DESC')
    .limit(3)
  end

end
