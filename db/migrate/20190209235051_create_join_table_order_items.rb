class CreateJoinTableOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.references :item_id, foreign_key: true
      t.references :order_id, foreign_key: true
      t.integer :order_price
      t.integer :order_quantity
      t.integer :fulfilled
      t.timestamps
    end
  end
end
