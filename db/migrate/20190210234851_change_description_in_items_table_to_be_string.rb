class ChangeDescriptionInItemsTableToBeString < ActiveRecord::Migration[5.1]
  def change
    change_column :items, :description, :string
  end
end
