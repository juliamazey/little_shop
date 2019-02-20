require 'rails_helper'

RSpec.describe 'As and admin' do
  context "when I visit a user's profile page" do
    before :each do
      @user_1 = create(:user)
      @user_2 = create(:user)
      @admin = create(:user, role: 2)
      @item_1 = create(:item, active: true)
      @item_2 = create(:item, active: true, stock: 20)
      @order_1 = create(:order, user_id: @user_1.id, status: 1)
      @order_items_1 = create(:order_item, item: @item_1, order: @order_1)
      @order_items_2 = create(:order_item, item: @item_2, order: @order_1)
    end

    xit "should see all the user info that a user would see" do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit admin_user_path(@user_1)

      expect(page).to have_content("#{@user_1.username}")
      expect(page).to have_content("#{@user_1.email}")
      expect(page).to have_content("#{@user_1.address}")
      expect(page).to have_content("#{@user_1.city}")
      expect(page).to have_content("#{@user_1.state}")
      expect(page).to have_content("#{@user_1.zip_code}")
      expect(page).to have_content("#{@user_1.username}'s Orders")

      expect(page).to_not have_content("#{@user_1.password}")
      expect(page).to_not have_content("#{@user_1.password_digest}")
      expect(page).to have_link ("Edit This Profile")
    end

    xit "should let the admin update the user info" do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit admin_user_path(@user_1)
      visit  profile_edit_path

      fill_in "user[username]", with: "Mickey Mouse"
      fill_in "user[email]", with: "mouse@disney.com"
      fill_in "user[address]", with: "123 Main Street"
      fill_in "user[city]", with: "Lake Buena Vista"
      fill_in "user[state]", with: "FL"
      fill_in "user[zip_code]", with: "32911"
      fill_in "user[password]", with: "test"
      fill_in "user[password_confirmation]", with: "test"

      click_button "Update User"

      expect(current_path).to eq(admin_user_path(User.last))

      expect(page).to have_content("Username: Mickey Mouse")
      expect(page).to have_content("Email: mouse@disney.com")
      expect(page).to have_content("Address: 123 Main Street")
      expect(page).to have_content("City: Lake Buena Vista")
      expect(page).to have_content("State: FL")
      expect(page).to have_content("Zip: 32911")
      expect(page).to have_content("User profile updated.")
    end

    xit "shows me an error message if the email address is in use" do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit admin_user_path(@user_1)
      visit  profile_edit_path

      fill_in "user[username]", with: "Mickey Mouse"
      fill_in "user[email]", with: @user_2.email
      fill_in "user[password]", with: "test"
      fill_in "user[password_confirmation]", with: "test"

      click_button "Update User"

      expect(current_path).to eq(profile_edit_path)

      expect(page).to have_content("That email address is already in use.")
    end

    it "can access the order's show page for a user" do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit admin_user_path(@user_1)

      click_on "#{@user_1.username}'s Orders"

      expect(current_path).to eq(admin_user_orders_path(@user_1))

      expect(page).to have_content("Total Items: 8")
      expect(page).to have_content("Grand Total: $32")
      expect(page).to have_link("Order # #{@order_1.id}")
      expect(page).to have_content("Date Order placed: #{@order_1.created_at}")
      expect(page).to have_content("Order Status: #{@order_1.status}")
      expect(page).to have_content("Last Updated: #{@order_1.updated_at}")
    end
  end
end
