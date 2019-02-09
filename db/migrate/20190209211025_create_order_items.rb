class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.integer :item_id
      t.integer :order_id
      t.integer :order_price
      t.integer :order_quantity
      t.integer :fulfilled
      t.timestamps
    end
  end
end
