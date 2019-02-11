class User < ApplicationRecord
  enum role: ['default', 'merchant', 'admin']
end
