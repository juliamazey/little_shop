require 'factory_bot_rails'

include FactoryBot::Syntax::Methods

OrderItem.destroy_all
Order.destroy_all
Item.destroy_all
User.destroy_all

admin = create(:user, role: 2)
user = create(:user)
merchant_1 = create(:user, role: 1)

merchant_2 = create(:user, role: 1)
merchant_3 = create(:user, role: 1)
merchant_4 = create(:user, role: 1)

inactive_merchant_1 = create(:user, role: 1, active: false)
inactive_user_1 = create(:user, active: false)

item_1 = create(:item, user: merchant_1, active: true)
item_2 = create(:item, user: merchant_2, active: true)
item_3 = create(:item, user: merchant_3, active: true)
item_4 = create(:item, user: merchant_4, active: true)
create_list(:item, 10, user: merchant_1, active: true)

inactive_item_1 = create(:item, user: merchant_1)
inactive_item_2 = create(:item, user: inactive_merchant_1)

Random.new_seed
rng = Random.new

order = create(:order, users_id: user.id, status: 2)
create(:order_item, order: order, item: item_1, order_price: 1, order_quantity: 1, created_at: (rng.rand(3)+1).days.ago, updated_at: rng.rand(59).minutes.ago, fulfilled: true)
create(:order_item, order: order, item: item_2, order_price: 2, order_quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago, fulfilled: true)
create(:order_item, order: order, item: item_3, order_price: 3, order_quantity: 1, created_at: (rng.rand(5)+1).days.ago, updated_at: rng.rand(59).minutes.ago, fulfilled: true)
create(:order_item, order: order, item: item_4, order_price: 4, order_quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago, fulfilled: true)

# pending order
order = create(:order, users_id: user.id)
create(:order_item, order: order, item: item_1, order_price: 1, order_quantity: 1)
create(:order_item, order: order, item: item_2, order_price: 2, order_quantity: 1, created_at: (rng.rand(23)+1).days.ago, updated_at: rng.rand(23).hours.ago, fulfilled: true)

order = create(:order, users_id: user.id, status: 1)
create(:order_item, order: order, item: item_2, order_price: 2, order_quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
create(:order_item, order: order, item: item_3, order_price: 3, order_quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)

order = create(:order, users_id: user.id, status: 2)
create(:order_item, order: order, item: item_1, order_price: 1, order_quantity: 1, created_at: (rng.rand(4)+1).days.ago, updated_at: rng.rand(59).minutes.ago, fulfilled: true)
create(:order_item, order: order, item: item_2, order_price: 2, order_quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago, fulfilled: true)





puts 'seed data finished'
puts "Users created: #{User.count.to_i}"
puts "Orders created: #{Order.count.to_i}"
puts "Items created: #{Item.count.to_i}"
puts "OrderItems created: #{OrderItem.count.to_i}"
