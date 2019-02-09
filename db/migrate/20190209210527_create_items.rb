class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.integer :user_id
      t.integer :price
      t.string :name
      t.string :image
      t.integer :stock
      t.integer :description
      t.integer :active
      t.timestamps
    end
  end
end
