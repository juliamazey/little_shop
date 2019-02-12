class AddUserAndItemsRelationship < ActiveRecord::Migration[5.1]
  def change
    remove_column :items, :user_id
    add_reference :items, :user, foreign_key: true
  end
end
