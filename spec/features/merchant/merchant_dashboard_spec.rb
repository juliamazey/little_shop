require 'rails_helper'

RSpec.describe "As a merchant" do
  describe "when i visit my dashboard" do
    before :each do
      @merchant_1 = create(:user, role: 1)
      @merchant_2 = create(:user, role: 1)
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
      buyer = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)

      item_1 = create(:item, active: true, user: @merchant_1)
      item_2 = create(:item, active: true, user: @merchant_1)
      order = create(:order, users_id: buyer.id)
      order_2 = create(:order, users_id: buyer.id, status: 1)

      order_item_1 = create(:order_item, order: order, item: item_1)
      order_item_2 = create(:order_item, order: order, item: item_2, order_price: 2, order_quantity: 2)
      order_item_3 = create(:order_item, order: order_2, item: item_2, order_price: 2, order_quantity: 2)

      visit merchant_dashboard_path(@merchant_1)

      expect(page).to have_link("Order # #{order.id}")
      expect(page).to have_content("Order placed at: #{order.created_at}")
      expect(page).to have_content("Total Quantity: #{order.total_items}")
      expect(page).to have_content("Total Value: #{order.grand_total}")
    end

    it 'sees an area with statistics' do

    end
  end
end
