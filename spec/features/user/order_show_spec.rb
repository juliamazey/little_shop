require 'rails_helper'


RSpec.describe "as a registered user" do
  context "when I visit an order's show page" do
    before :each do
      @user = create(:user)
      @item_1 = create(:item, active: true)
      @item_2 = create(:item, active: true)
      @item_3 = create(:item, active: true)
      @order = create(:order, user_id: @user.id)
      @order_items_1 = create(:order_item, item: @item_1, order: @order, fulfilled: true)
      @order_items_2 = create(:order_item, item: @item_2, order: @order, fulfilled: true)
      @order_items_3 = create(:order_item, item: @item_3, order: @order)
    end

    it 'shows me the information of a specific order when I click on it' do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit user_profile_orders_path(@user)

      click_on @order.id

      expect(current_path).to eq(user_order_path(@user, @order))

      expect(page).to have_content("Order # #{@order.id}")

      within ".order-info" do
      expect(page).to have_content("Order made on the #{@order.created_at}")
      expect(page).to have_content("Order last updated on the #{@order.updated_at}")
      expect(page).to have_content("Status: #{@order.status}")
      end

      within "#order-items-#{@order.id}" do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.description)
      expect(page).to have_xpath('//img[@src="http://theepicentre.com/wp-content/uploads/2012/07/cinnamon.jpg"]')
      expect(page).to have_content("Item Price: $#{@item_2.price}")
      expect(page).to have_content("Quantity bought: #{@order_items_2.order_quantity}")
      expect(page).to have_content("Subtotal: $#{@order_items_1.order_price}")
      end

      expect(page).to have_content("Total items in order: #{@order.total_items}")
      expect(page).to have_content("Grand total: $#{@order.grand_total}")
    end

    it "can cancel a pending order" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit user_order_path(@user, @order)

      @item_1.deducts_stock(@order_items_1.order_quantity)
      @item_2.deducts_stock(@order_items_2.order_quantity)
      @item_3.deducts_stock(@order_items_3.order_quantity)

      within ".order-info" do
        click_on "Cancel order"
      end

      expect(Order.all.first.status).to eq("cancelled")

      order_items = OrderItem.all

      status_unfulfilled = order_items.all? {|order_item| order_item.fulfilled == false}
      expect(status_unfulfilled).to eq(true)

      items = Item.all

      restocked = items.all? {|item| item.stock == 7}

      expect(restocked).to eq(true)

      expect(current_path).to eq(profile_path)

      expect(page).to have_content("Order has been cancelled")

      within ".cancelled-orders" do
        expect(page).to have_content(@order.id)
      end
    end
  end
end
