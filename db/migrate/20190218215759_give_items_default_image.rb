class GiveItemsDefaultImage < ActiveRecord::Migration[5.1]
  def change
    remove_column :items, :image
    add_column :items, :image, :string, default: "https://secure.img1-fg.wfcdn.com/im/43152120/resize-h600-w600%5Ecompr-r85/4486/44869893/12+Jar+Spice+Jars+%26+Rack+Set.jpg"
  end
end
