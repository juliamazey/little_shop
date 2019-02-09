class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :role
      t.string :username
      t.string :password
      t.string :confirmed_password
      t.string :email
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip_code
      t.integer :active
      t.timestamps
    end
  end
end
