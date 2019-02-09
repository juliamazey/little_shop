class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.references :user_id, foreign_key: true
      t.integer :price
      t.string :name
      t.string :image
      t.integer :stock
      t.string :description
      t.integer :active
      t.timestamps
    end
  end
end
