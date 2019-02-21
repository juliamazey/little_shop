class ChangeOrderTable < ActiveRecord::Migration[5.1]
  def change
    rename_column :orders, :users_id, :user_id
  end
end
