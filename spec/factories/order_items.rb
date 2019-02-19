FactoryBot.define do
  factory :order_item do
    fulfilled { false }
    item
    order
    order_quantity { 4 }
    order_price { (item.price) * self.order_quantity }
  end
end
