class ChangeUsersRole < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :role
    rename_column :users, :password, :password_digest
    remove_column :users, :confirmed_password
    add_column :users, :role, :integer
  end
end
