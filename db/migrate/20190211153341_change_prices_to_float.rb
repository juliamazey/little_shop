class ChangePricesToFloat < ActiveRecord::Migration[5.1]
  def change
    change_column :items, :price, :float
  end
end
