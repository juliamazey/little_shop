require 'rails_helper'

RSpec.describe Order, type: :model do

  before :each do
    @merchant_1 = User.create!(username: "Scary Spice", email: "scarier@spicegirls.com", password: "dontbescared", address: "123 Thames Street", city: "London", state: "NY", zip_code: 12345, role: "merchant", active: 1)
    @spice_1 = @merchant_1.items.create!(price: 20.00, name: "cinnamon", stock: 12, description: "3 inch sticks", active: 1, image: "https://www.herbazest.com/imgs/4/2/b/81361/cinnamon.jpg")
    @user_1 = User.create!(username: "mom", email: "mother@mothers.com", password: "baking", address: "123 Turing Street", city: "Chicago", state: "NY", zip_code: 12345, role: "default", active: 1)
    @order_1 = Order.create!(users_id: @user_1.id, status: "fulfilled", quantity: 10, created_at: 4.days.ago)
    @orderitem_1 = OrderItem.create!(order_id: @order_1, item_id: @spice_1, order_price: 22.00, order_quantity: 6, fulfilled: true)
    # create(:order_item, order: order, item: item_1, unit_price: 1, quantity: 1)
  # @order_2 = @user_1.orders.create!(status: "fulfilled", quantity: 20, created_at: 5.days.ago)order_id: @order_1.id, item_id: @spice_1.id,
  # @order_3 = @user_1.orders.create!(status: "fulfilled", quantity: 30, created_at: 3.days.ago)
end


  describe "instance methods" do
    describe "average amount of time it takes merchant to fulfill an item" do
        it "shows average time" do
          binding.pry
      # spice_1.average_fulfillment

      expect(@spice_1.average_fulfillment).to eq(4)
    end

  end

    it '.total_items' do
      user = create(:user)
      item_1 = create(:item, active: true)
      item_2 = create(:item, active: true, stock: 20)

      order_1 = create(:order, users_id: user.id)
      order_2 = create(:order, users_id: user.id)

      order_items_1 = create(:order_item, item: item_1, order: order_1)
      order_items_2 = create(:order_item, item: item_2, order: order_1)
      order_items_3 = create(:order_item, item: item_2, order: order_2)

      expect(order_1.total_items).to eq(8)
      expect(order_2.total_items).to eq(4)
    end

    it '.grand_total' do
      user = create(:user)
      item_1 = create(:item, active: true)
      item_2 = create(:item, active: true, stock: 20)

      order_1 = create(:order, users_id: user.id)

      order_items_1 = create(:order_item, item: item_1, order: order_1)
      order_items_2 = create(:order_item, item: item_2, order: order_1)

      expect(order_1.grand_total).to eq(32)
    end
  end



end
