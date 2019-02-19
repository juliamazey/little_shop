class DeleteActiveColumnForItems < ActiveRecord::Migration[5.1]
  def change
    remove_column :items, :active
  end
end
