class FixedOrderItems < ActiveRecord::Migration[5.1]
  def change
    remove_column :order_items, :item_id
    remove_column :order_items, :order_id
    remove_column :order_items, :orders_id
    remove_column :order_items, :items_id

    add_reference :order_items, :item, index: true
    add_reference :order_items, :order, index: true
  end
end
