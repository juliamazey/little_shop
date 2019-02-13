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
end
