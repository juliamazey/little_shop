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

end
