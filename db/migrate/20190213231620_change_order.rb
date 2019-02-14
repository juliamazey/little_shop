class ChangeOrder < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :user_id
    add_reference :orders, :users, foreign_key: true
  end
end
