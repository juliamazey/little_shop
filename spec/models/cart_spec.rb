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
end
