class ChangeOrderItemFulfilledColumnToBoolean < ActiveRecord::Migration[5.1]
  def change
    remove_column :order_items, :fulfilled
    add_column :order_items, :fulfilled, :boolean, default: false
  end
end
