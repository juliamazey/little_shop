require 'rails_helper'
RSpec.describe "As a merchant" do
  describe "when i visit my dashboard" do
    before :each do
      @merchant_1 = create(:user, role: 1)
      @item_1 = create(:item, active: true, user: @merchant_1, stock: 500)
      @item_2 = create(:item, active: true, user: @merchant_1, stock: 500)
      @item_3 = create(:item, active: true, user: @merchant_1, stock: 500)
      @item_4 = create(:item, active: true, user: @merchant_1, stock: 500)
      @item_5 = create(:item, active: true, user: @merchant_1, stock: 500)
      @item_6 = create(:item, active: true, user: @merchant_1, stock: 500)
      @user_1 = create(:user)
      @user_2 = create(:user, city: "Salt Lake city", state: "utah")
      @user_3 = create(:user, city: "saint paul", state: "minnesota")
      @user_4 = create(:user, city: "new york city", state: "new york")
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
      order = create(:order, user_id: @user_1.id)
      order_2 = create(:order, user_id: @user_1.id, status: 1)
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
     order_1 = create(:order, user_id: @user_1.id)
     order_2 = create(:order, user_id: @user_1.id)
     order_3 = create(:order, user_id: @user_1.id)
     order_4 = create(:order, user_id: @user_2.id)
     order_5 = create(:order, user_id: @user_2.id)
     order_6 = create(:order, user_id: @user_3.id)
     order_7 = create(:order, user_id: @user_3.id)
     order_8 = create(:order, user_id: @user_4.id)
     order_item_1 = create(:order_item, order: order_1, item: @item_1, order_quantity: 40)
     order_item_2 = create(:order_item, order: order_1, item: @item_2, order_quantity: 35)
     order_item_3 = create(:order_item, order: order_2, item: @item_3, order_quantity: 31)
     order_item_4 = create(:order_item, order: order_2, item: @item_4, order_quantity: 30)
     order_item_5 = create(:order_item, order: order_3, item: @item_5, order_quantity: 28)
     order_item_6 = create(:order_item, order: order_3, item: @item_6, order_quantity: 20)
     order_item_7 = create(:order_item, order: order_4, item: @item_1, order_quantity: 15)
     order_item_8 = create(:order_item, order: order_4, item: @item_2, order_quantity: 15)
     order_item_9 = create(:order_item, order: order_5, item: @item_3, order_quantity: 15)
     order_item_10 = create(:order_item, order: order_5, item: @item_4, order_quantity: 15)
     order_item_11 = create(:order_item, order: order_6, item: @item_2, order_quantity: 16)
     order_item_12 = create(:order_item, order: order_6, item: @item_3, order_quantity: 15)
     order_item_13 = create(:order_item, order: order_7, item: @item_4, order_quantity: 15)
     order_item_14 = create(:order_item, order: order_7, item: @item_5, order_quantity: 15)
     order_item_15 = create(:order_item, order: order_8, item: @item_1, order_quantity: 15)
     order_item_16 = create(:order_item, order: order_8, item: @item_2, order_quantity: 15)
     order_item_17 = create(:order_item, order: order_8, item: @item_3, order_quantity: 15)
     order_item_18 = create(:order_item, order: order_8, item: @item_4, order_quantity: 15)
     order_item_19 = create(:order_item, order: order_8, item: @item_5, order_quantity: 15)

     visit merchant_dashboard_path(@merchant_1)
     expect(page).to have_content("Top 5 Items:\n#{@item_2.name}, total quantity sold: #{@item_2.quantity_sold}")
     # item 2 = 81; item 3 = 76; item 5 = 75
     within ".total-sold" do
       expect(page).to have_content(380)
       expect(page).to have_content("Sold 380 items, which is 11% of your total inventory")
     end      #3000 is the total inventory, 380 sold

     within ".top-states" do
       expect(page).to have_content(@user_1.state)
       expect(page).to have_content(@user_3.state)
     end      # who was the user that bought more items? user_1, user_4, user_3
     #user_1 (CO, bought 184 items); user_4(new york, bought 75 items); user_3(minnesota, bought 61 items)

     within ".top-cities" do
       expect(page).to have_content("Top 3 Cities:\n#{@user_1.city}\n#{@user_4.city}\n#{@user_3.city}")
       expect(page).to_not have_content(@user_2.city)
     end      #user_1 (testville, bought 184 items); user_4(new york, bought 75 items); user_3(saint paul, bought 61 items)

     within ".top-users" do
       expect(page).to have_content("Top Consumer:\n#{@user_1.username}: 6")
       #user_1 bought 184 items, 6 orders
     end
     within ".top-spenders" do
       expect(page).to have_content("Top Spenders:\n#{@user_1.username}:")
       expect(page).to have_content("#{@user_4.username}:")
       expect(page).to have_content("#{@user_3.username}:")
       #price is 4 for every item, so it would be the same results as in line 110
       #user 1 spent 736, user 4 spent 300, user 3 spent 244
     end
   end
   it 'has a link to view my items' do
     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)
     visit merchant_dashboard_path(@merchant_1)
     click_link "My Items"
     expect(current_path).to eq(merchant_dashboard_items_path)
     expect(page).to have_content(@item_1.name)
     expect(page).to have_content("Stock: #{@item_2.stock}")
   end
   it "i see pending orders with items" do
     buyer = create(:user)
     merchant_1 = create(:user, role: 1)
     merchant_2 = create(:user, role: 1)
     item_1 = create(:item, active: true, user: merchant_1)
     item_2 = create(:item, active: true, user: merchant_2)
     order = create(:order, user: buyer)
     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)
     visit merchant_dashboard_path(merchant_1)
   end
  end
end
