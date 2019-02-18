require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'As a merchant' do
  before :each do
    @merchant = create(:user, role: 1)
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
save_and_open_page 
      expect(page).to have_content("This item is no longer for sale.")
      expect(page).to have_content("Enable")
    end

    it 'can add a new item' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)

      visit merchant_dashboard_items_path

      expect(page).to have_content("Add Item")
      expect(page).to have_content(@item_1.id)
      expect(page).to have_content(@item_1.name)
      expect(page).to have_xpath('//img[@src="http://theepicentre.com/wp-content/uploads/2012/07/cinnamon.jpg"]')
      expect(page).to have_content("Price: #{number_to_currency(@item_1.price)}")
      expect(page).to have_content("Stock: #{@item_1.stock}")
      expect(page).to have_content(@item_2.name)
      expect(page).to_not have_content(@item_3.name)

      within "#item-#{@item_2.id}" do
        expect(page).to have_content("Edit Item")
        expect(page).to have_content("Disable")
        expect(page).to_not have_content("Delete")
      end
      within "#item-#{@item_4.id}" do
        expect(page).to have_content("Enable")
      end

      within "#item-#{@item_1.id}" do
        expect(page).to have_content("Delete")
      end
    end
  end
end
