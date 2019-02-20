require 'rails_helper'
RSpec.describe 'As an admin user' do
  before :each do
    @merchant = create(:user, role: 1)
    @user = create(:user, role: 0)
    @admin = create(:user, role: 2)
    @item = create(:item, user: @merchant)
  end
  describe "When I visit a merchant's dashboard" do #/admin/merchants/6
    it 'sees a link to downgrade the merchant account' do# to become a regular user
      # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit login_path

      fill_in 'Email', with: @admin.email
      fill_in 'Password', with: @admin.password
      click_on "Log in"

      visit admin_merchant_dashboard_path(@merchant)
      click_on "Downgrade" #The merchant themselves do NOT see this link

      expect(current_path).to eq(admin_user_path(@merchant)) #because the merchant is now a regular user
      expect(page).to have_content("This user has been downgraded.")

      visit merchant_dashboard_items_path(@merchant)
      expect(page).to_not have_content(@item.name)
    end

    it "sees a link to this merchant's items" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit admin_merchant_dashboard_path(@merchant)
      expect(page).to have_link("#{@merchant.username}'s Items")

      click_on "#{@merchant.username}'s Items"

      expect(current_path).to eq(admin_dashboard_items_path(@merchant))
      expect(page).to have_content("#{@item.name}")
    end

    it "can add a new item" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit admin_dashboard_items_path(@merchant)

      expect(page).to have_link("Add Item")

      click_on "Add Item"

      expect(current_path).to eq(admin_item_new_path(@merchant))

      fill_in "Name", with: "Thyme"
      fill_in "Description", with: "We don't have enough of it"
      fill_in "Price", with: 4.00
      fill_in "Stock", with: 20

      click_on "Create Item"

      expect(current_path).to eq(admin_dashboard_items_path(@merchant))
      expect(page).to have_content("Item saved!")
      expect(page).to have_content("Thyme")
    end

    it "cannot create an item with missing fields" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit admin_item_new_path(@merchant)

      fill_in "Name", with: "Thyme"
      fill_in "Description", with: "We don't have enough of it"
      fill_in "Price", with: 4.00

      click_on "Create Item"

      expect(current_path).to eq(admin_item_new_path(@merchant))
      expect(page).to have_content("All non-image fields are required")
    end

    it "can edit an item" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit admin_dashboard_items_path(@merchant)

      within "#item-#{@item.id}" do
        expect(page).to have_link("Edit Item")
        click_on "Edit Item"
      end

      expect(current_path).to eq(admin_edit_item_path(@item))

      fill_in "Name", with: "Thyme"
      fill_in "Description", with: "We don't have enough of it"
      fill_in "Price", with: 4.00
      fill_in "Stock", with: 20

      click_on "Update Item"

      expect(current_path).to eq(admin_dashboard_items_path(@merchant))
      expect(page).to have_content("Thyme")
      expect(page).to have_content("Item updated!")
    end

    it "cannot edit an item without all fields" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit admin_dashboard_items_path(@merchant)

      within "#item-#{@item.id}" do
        expect(page).to have_link("Edit Item")
        click_on "Edit Item"
      end

      fill_in "Name", with: "Thyme"
      fill_in "Description", with: "We don't have enough of it"
      fill_in "Price", with: 4.00
      fill_in "Stock", with: ""

      click_on "Update Item"

      expect(current_path).to eq(admin_edit_item_path(@item))
      expect(page).to have_content("All non-image fields are required")
    end

    it "can delete an item" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit admin_dashboard_items_path(@merchant)

      within "#item-#{@item.id}" do
        expect(page).to have_link("Delete this item")
        click_on "Delete this item"
      end

      expect(page).to_not have_content("#{@item.name}")
    end

  end
  describe 'I visit a merchant dashboard, but that merchant is a regular user' do
    it 'is redirectred to the user profile' do
      visit login_path

      fill_in 'Email', with: @admin.email
      fill_in 'Password', with: @admin.password
      click_on "Log in"

      visit admin_merchant_dashboard_path(@user)
      expect(current_path).to eq(admin_user_path(@user))
      # expect(page).to have_current_path(admin_user_path(@merchant))      # Then I am redirected to the appropriate user profile page.
    end
  end
end
