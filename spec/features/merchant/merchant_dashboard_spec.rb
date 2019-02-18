require 'rails_helper'

RSpec.describe "As a merchant" do
  describe "when i visit my dashboard" do
    before :each do
      @merchant_1 = create(:user, role: 1)
      @item_1 = create(:item, active: true, user: @merchant_1, stock: 50)
      @item_2 = create(:item, active: true, user: @merchant_1, stock: 50)
      @item_3 = create(:item, active: true, user: @merchant_1, stock: 50)
      @item_4 = create(:item, active: true, user: @merchant_1, stock: 50)
      @item_5 = create(:item, active: true, user: @merchant_1, stock: 50)
      @item_6 = create(:item, active: true, user: @merchant_1, stock: 50)
      @user_1 = create(:user)
      @user_2 = create(:user, city: "denver", state: "utah")
      @user_3 = create(:user, city: "saint paul", state: "minnesota")
      @user_4 = create(:user, city: "new york", state: "new york")
    end

    it "should see my profile data, and can not edit it" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)

      visit merchant_dashboard_path(@merchant_1)

      expect(page).to have_content(@merchant_1.username)
      expect(page).to have_content(@merchant_1.email)
      expect(page).to have_content(@merchant_1.address)
      expect(page).to have_content(@merchant_1.city)
      expect(page).to have_content(@merchant_1.state)
      expect(page).to have_content(@merchant_1.zip_code)

      expect(page).to_not have_link("Edit My Profile")
    end

    it "i see pending orders with items" do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)

      order = create(:order, users_id: @user_1.id)
      order_2 = create(:order, users_id: @user_1.id, status: 1)

      order_item_1 = create(:order_item, order: order, item: @item_1)
      order_item_2 = create(:order_item, order: order, item: @item_2, order_price: 2, order_quantity: 2)
      order_item_3 = create(:order_item, order: order_2, item: @item_2, order_price: 2, order_quantity: 2)

      visit merchant_dashboard_path(@merchant_1)

      expect(page).to have_link("Order # #{order.id}")
      expect(page).to have_content("Order placed at: #{order.created_at}")
      expect(page).to have_content("Total Quantity: #{order.total_items}")
      expect(page).to have_content("Total Value: #{order.grand_total}")
    end

    it 'sees an area with statistics' do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)

      order_1 = create(:order, users_id: @user_1.id)
      order_2 = create(:order, users_id: @user_1.id)
      order_3 = create(:order, users_id: @user_1.id)
      order_4 = create(:order, users_id: @user_2.id)
      order_5 = create(:order, users_id: @user_2.id)
      order_6 = create(:order, users_id: @user_3.id)
      order_7 = create(:order, users_id: @user_3.id)
      order_8 = create(:order, users_id: @user_4.id)

      order_item_1 = create(:order_item, order: order_1, item: @item_1)
      order_item_2 = create(:order_item, order: order_1, item: @item_2)
      order_item_3 = create(:order_item, order: order_2, item: @item_3)
      order_item_4 = create(:order_item, order: order_2, item: @item_4)
      order_item_5 = create(:order_item, order: order_3, item: @item_5)
      order_item_6 = create(:order_item, order: order_3, item: @item_6)
      order_item_7 = create(:order_item, order: order_4, item: @item_1)
      order_item_8 = create(:order_item, order: order_4, item: @item_2)
      order_item_9 = create(:order_item, order: order_5, item: @item_3)
      order_item_10 = create(:order_item, order: order_5, item: @item_4)
      order_item_11 = create(:order_item, order: order_6, item: @item_2)
      order_item_12 = create(:order_item, order: order_6, item: @item_3)
      order_item_13 = create(:order_item, order: order_7, item: @item_4)
      order_item_14 = create(:order_item, order: order_7, item: @item_5)
      order_item_15 = create(:order_item, order: order_8, item: @item_1)
      order_item_16 = create(:order_item, order: order_8, item: @item_2)
      order_item_17 = create(:order_item, order: order_8, item: @item_3)
      order_item_18 = create(:order_item, order: order_8, item: @item_4)
      order_item_19 = create(:order_item, order: order_8, item: @item_5)

      visit merchant_dashboard_path(@merchant_1)

      expect(page).to have_content("Top 5 Items: #{@item_1.name}, #{@item_2.name}, #{@item_3.name}, #{@item_4.name}, #{@item_5.name}")

    end
  end
end
