require 'rails_helper'

RSpec.describe 'As a merchant' do
  before :each do
    @merchant = create(:user, role: 1)
    @user_1 = create(:user, role: 0)
    @user_2 = create(:user, role: 0)
    @user_3 = create(:user, role: 0)
    @item_1 = create(:item, active: true, user: @merchant)
    @item_2 = create(:item, active: true, user: @merchant)
    @item_3 = create(:item, active: true)
    @item_4 = create(:item, active: false, user: @merchant)
    @order_1 = create(:order, item: @item_2, user: @user_1)
    @order_2 = create(:order, item: @item_1, user: @user_2)
    @order_3 = create(:order, item: @item_3, user: @user_3)
    @order_item_2 = create(:order_item, item: @item_2, order: @order_1)
    @order_item_3 = create(:order_item, item: @item_1, order: @order_2)
    @order_item_4 = create(:order_item, item: @item_3, order: @order_3)
  end
  describe 'When I visit an order show page from my dashboard' do
    it 'can see only items sold by it' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)

      visit merchant_dashboard_orders_path
      
      expect(page).to have_content(@user_1.username)
      expect(page).to have_content(@user_1.address)
      expect(page).to_not have_content(@user_3.username)
      # - the name of the item, which is a link to my item's show page
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@item_2.image)
      expect(page).to have_content(@order_item_2.order_price)
      expect(page).to have_content(@order_item_2.order_quantity)
    end
  end
end
