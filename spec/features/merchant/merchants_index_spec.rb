require 'rails_helper'

RSpec.describe "As a visitor" do
  before :each do
    @merchant_1 = create(:user, role: 1)
    @merchant_2 = create(:user, role: 1, created_at: "Sun, 16 Feb 2019 23:09:01 UTC +00:00")
    @merchant_3 = create(:user, role: 1)
    @merchant_4 = create(:user, role: 1)
    @merchant_5 = create(:user, role: 1, active: false)
    @item_1 = create(:item, active: true, user: @merchant_1, stock: 50)
    @item_2 = create(:item, active: true, user: @merchant_1, stock: 50)
    @item_3 = create(:item, active: true, user: @merchant_2, stock: 50)
    @item_4 = create(:item, active: true, user: @merchant_2, stock: 50)
    @item_5 = create(:item, active: true, user: @merchant_4, stock: 50)
    @item_6 = create(:item, active: true, user: @merchant_4, stock: 50)
    @item_7 = create(:item, active: true, user: @merchant_3, stock: 50)
    @user_1 = create(:user, city: "Atlanta", state: "georgia")
    @user_2 = create(:user, city: "denver", state: "colorado")
    @user_3 = create(:user, city: "saint paul", state: "minnesota")
    @user_4 = create(:user, city: "new york", state: "new york")
    @order_1 = create(:order, user_id: @user_1.id)
    @order_2 = create(:order, user_id: @user_1.id)
    @order_3 = create(:order, user_id: @user_1.id)# Atlanta, 4 orders
    @order_4 = create(:order, user_id: @user_2.id)
    @order_5 = create(:order, user_id: @user_2.id)# denver, 2 orders
    @order_6 = create(:order, user_id: @user_3.id)
    @order_7 = create(:order, user_id: @user_3.id)# st paul, 2 orders
    @order_8 = create(:order, user_id: @user_4.id)# new york, 1 order
    @order_item_1 = create(:order_item, order: @order_1, item: @item_1, order_quantity: 40)# 160
    @order_item_7 = create(:order_item, order: @order_4, item: @item_1)# 16
    @order_item_15 = create(:order_item, order: @order_8, item: @item_1)# 16
    @order_item_2 = create(:order_item, order: @order_1, item: @item_2, order_quantity: 35)# 140
    @order_item_8 = create(:order_item, order: @order_4, item: @item_2)# 16
    @order_item_11 = create(:order_item, order: @order_6, item: @item_2)# 16
    @order_item_16 = create(:order_item, order: @order_8, item: @item_2)# 16
    #merchant 1 - total revenue = 380
    @order_item_3 = create(:order_item, order: @order_2, item: @item_3, order_quantity: 32)# 128
    @order_item_9 = create(:order_item, order: @order_5, item: @item_3)# 16
    @order_item_12 = create(:order_item, order: @order_6, item: @item_3)# 16
    @order_item_17 = create(:order_item, order: @order_8, item: @item_3)# 16
    @order_item_4 = create(:order_item, order: @order_2, item: @item_4, order_quantity: 30)# 120
    @order_item_10 = create(:order_item, order: @order_5, item: @item_4, order_quantity: 10)# 40
    @order_item_18 = create(:order_item, order: @order_8, item: @item_4)# 16
    @order_item_13 = create(:order_item, order: @order_7, item: @item_4)# 16
    #merchant 2 - total revenue = 368
    @order_item_5 = create(:order_item, order: @order_3, item: @item_5, order_quantity: 28)# 112
    @order_item_14 = create(:order_item, order: @order_7, item: @item_5)# 16
    @order_item_19 = create(:order_item, order: @order_8, item: @item_5)# 16
    @order_item_6 = create(:order_item, order: @order_3, item: @item_6, order_quantity: 20)# 80
    # merchant 4 - total revenue = 224
    @order_item_6 = create(:order_item, order: @order_3, item: @item_7, order_quantity: 20)# 80
    # merchant 3 - total revenue = 80
  end
  context "when I visit '/merchants'" do
    it "displays all active merchants in the system" do

      visit merchants_path

      expect(page).to have_content(@merchant_1.username)
      expect(page).to have_content(@merchant_2.created_at)
      expect(page).to have_content(@merchant_3.city)
      expect(page).to have_content(@merchant_4.state)

      expect(page).to_not have_content(@merchant_5.username)
    end
    it 'I see an area with statistics' do
      visit merchants_path

      # - top 3 merchants who have sold the most by price and quantity, and their revenue
      within ".top-rev" do
        expect(page).to have_content("Highest Revenue:\n#{@merchant_1.username}")#: 380
        expect(page).to have_content("#{@merchant_2.username}")#: 368
        expect(page).to have_content("#{@merchant_4.username}")#: 224
      end
      # - top 3 merchants who were fastest at fulfilling items in an order, and their times
      # - worst 3 merchants who were slowest at fulfilling items in an order, and their times
save_and_open_page
      # - top 3 states where any orders were shipped (by number of orders), and count of orders
      within ".top-states" do
        expect(page).to have_content("Top States by Orders:\n#{@user_1.state}")
        expect(page).to have_content("#{@user_2.state}")
        expect(page).to have_content("#{@user_3.state}")
      end
      # - top 3 cities where any orders were shipped (by number of orders, also Springfield, MI should not be grouped with Springfield, CO), and the count of orders
      within ".top-cities" do
        expect(page).to have_content("Top Cities by Orders:\n#{@user_1.city}")
        expect(page).to have_content("#{@user_2.city}")
        expect(page).to have_content("#{@user_3.city}")
      end
      # - top 3 biggest orders by quantity of items shipped in an order, plus their quantities
    end
  end
end
