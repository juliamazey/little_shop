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
    @order = create(:order, user: @buyer)
    @order_item_2 = create(:order_item, item: @item_3, order: @order)
    @order_item_3 = create(:order_item, item: @item_3, order: @order)

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

      expect(current_path).to eq(merchant_dashboard_item_new_path)
    end

    it "can fill out a form to add a new item" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)

      visit merchant_dashboard_items_path

      click_on "Add Item"

      fill_in "Name", with: "Thyme"
      fill_in "Description", with: "We don't have enough of it"
      fill_in "Price", with: 4.00
      fill_in "Stock", with: 20

      click_on "Create Item"
      # save_and_open_page
      expect(current_path).to eq(merchant_dashboard_items_path)
      expect(page).to have_content("Item saved!")
      expect(page).to have_content("Thyme")
    end

    it "has a link to delete an item" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)

      visit merchant_dashboard_items_path

      within "#item-#{@item_2.id}" do
        expect(page).to have_link("Delete this item")
        click_on "Delete this item"
      end

      expect(page).to_not have_content("#{@item_2.name}")

    end
  end
end
