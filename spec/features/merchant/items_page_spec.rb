require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'As a merchant' do
  before :each do
    @merchant = create(:user, role: 1)
    @buyer = create(:user)
    @item_1 = create(:item, active: true, user: @merchant)
    @item_2 = create(:item, active: true, user: @merchant)
    @item_3 = create(:item, active: true)
    @item_4 = create(:item, active: false, user: @merchant)
    @order_item_2 = create(:order_item, item: @item_2)
    @order_item_3 = create(:order_item, item: @item_2)

  end

  describe 'When I visit my /dashboard/items page' do
    it 'can disable an item' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)

      visit merchant_dashboard_items_path
      within "#item-#{@item_2.id}" do
        click_on "Disable"
      end

      expect(page).to have_content("This item is no longer for sale.")
      expect(page).to have_content("Enable")
    end

    it 'can click on a link and be taken to a new item form' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)

      visit merchant_dashboard_items_path

      expect(page).to have_content("Add Item")

      click_on "Add Item"

      expect(current_path).to eq(merchant_new_item_path)
    end
  end
end
