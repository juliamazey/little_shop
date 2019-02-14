FactoryBot.define do
  factory :order_item do
    fulfilled { false }
    item
    order
    order_price { item.price }
    order_quantity { order.quantity }
  end
end
