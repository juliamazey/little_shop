require 'rails_helper'

RSpec.describe 'As a registered user' do
  context 'when I visit my orders page' do
    before :each do
      @user = create(:user)
      @item_1 = create(:item, active: true)
      @item_2 = create(:item, active: true, stock: 20)
      @order_1 = create(:order, user_id: @user.id)
      @order_2 = create(:order, user_id: @user.id, created_at: "2018-02-16 20:10:48 UTC", updated_at: "2018-02-16 20:10:48 UTC", status: 2)
      @order_items_1 = create(:order_item, item: @item_1, order: @order_1)
      @order_items_2 = create(:order_item, item: @item_2, order: @order_1)
      @order_items_3 = create(:order_item, item: @item_2, order: @order_2, order_quantity: 6)

    end
    it 'displays all my orders' do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit user_profile_orders_path(@user)

      within "#order-#{@order_1.id}" do

      expect(page).to have_content("Total Items: 8")
      expect(page).to have_content("Grand Total: $32")
      expect(page).to have_link("Order # #{@order_1.id}")
      expect(page).to have_content("Date Order placed: #{@order_1.created_at}")
      expect(page).to have_content("Order Status: #{@order_1.status}")
      expect(page).to have_content("Last Updated: #{@order_1.updated_at}")

      expect(page).to_not have_link("#{@order_2.id}")
      expect(page).to_not have_content("#{@order_2.created_at}")
      expect(page).to_not have_content("#{@order_2.updated_at}")
      expect(page).to_not have_content("#{@order_2.status}")
      end

    end
    it 'shows me the information of a specific order when I click on it' do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit user_profile_orders_path(@user)

      click_on @order_1.id

      expect(current_path).to eq(user_order_path(@user, @order_1))

      expect(page).to have_content("Order # #{@order_1.id}")

      within ".order-info" do
      expect(page).to have_content("Order made on the #{@order_1.created_at}")
      expect(page).to have_content("Order last updated on the #{@order_1.updated_at}")
      expect(page).to have_content("Status: #{@order_1.status}")
      end

      within "#order-items-#{@order_1.id}" do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.description)
      expect(page).to have_xpath('//img[@src="http://theepicentre.com/wp-content/uploads/2012/07/cinnamon.jpg"]')
      expect(page).to have_content("Item Price: $#{@item_2.price}")
      expect(page).to have_content("Quantity bought: #{@order_items_2.order_quantity}")
      expect(page).to have_content("Subtotal: $#{@order_items_1.order_price}")
      end

      expect(page).to have_content("Total items in order: #{@order_1.total_items}")
      expect(page).to have_content("Grand total: $#{@order_1.grand_total}")

    end
  end
end
