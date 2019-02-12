class ChangeOrderItems < ActiveRecord::Migration[5.1]
  def change
    change_column :order_items, :order_price, :float
    add_reference :order_items, :items, index: true
    add_reference :order_items, :orders, index: true
  end
end
