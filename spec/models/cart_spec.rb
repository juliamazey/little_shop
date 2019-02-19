require 'rails_helper'
RSpec.describe Cart do

  describe "#total_count" do
    it 'can calculate the total number of items' do
      cart = Cart.new({
        "1" => "5",
        "2" => "3"
        })
      expect(cart.total_count).to eq(8)
    end
  end
  describe 'add #item' do
    it 'should add an item to our cart' do
      cart = Cart.new({
        "1" => "5",
        "2" => "3"
        })
      cart.add_item("1")
      cart.add_item("2")
      expect(cart.contents).to eq({"1" => "6", "2" => "4"})
    end
  end

  it 'can get items' do
    item1, item2 = create_list(:item, 2)
    cart = Cart.new({})
    cart.add_item(item1.id)
    cart.add_item(item2.id)
    expect(cart.get_items).to eq([item1,item2])
  end

  it 'can calculate the cart subtotal' do
    item1, item2 = create_list(:item, 2)
    cart = Cart.new({
      "#{item1.id}" => "5",
      "#{item2.id}" => "3"
      })
      cart.add_item(item1.id.to_s)
      cart.add_item(item2.id.to_s)
      expect(cart.subtotal(item1)).to eq(24)
      expect(cart.subtotal(item2)).to eq(16)
  end

  it 'can calculate the cart Grand total' do
    item1 = create(:item, id:1)
    item2 = create(:item, id:2)
    cart = Cart.new({
      "#{item1.id}" => "5",
      "#{item2.id}" => "3"
      })
      cart.add_item(item1.id.to_s)
      cart.add_item(item2.id.to_s)
      expect(cart.grand_total).to eq(40)
  end
end
