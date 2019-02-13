class User < ApplicationRecord
  has_many :items
  has_secure_password
  has_many :items

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, require: true

  enum role: ['default', 'merchant', 'admin']

end
