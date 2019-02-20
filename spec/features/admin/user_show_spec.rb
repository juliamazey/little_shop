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

    it "sees a link to turn a user to a merchant" do
      user_1 = create(:user)
      admin = create(:user, role: 2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_user_path(user_1)

      expect(page).to have_link("Change this user to a merchant")
    end

    it "can turn a user to a merchant" do
      user_1 = create(:user)
      admin = create(:user, role: 2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_user_path(user_1)

      click_on "Change this user to a merchant"

      expect(page).to have_content("User Upgraded to Merchant")
      expect(current_path).to eq(admin_merchant_dashboard_path(user_1))
    end

    it "is redirected to a merchants page if visiting a user's page who is a merchant" do
      merchant = create(:user, role: 1)
      admin = create(:user, role: 2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_user_path(merchant)

      expect(current_path).to eq(admin_merchant_dashboard_path(merchant))
      
    it "can access the order's index page for a user" do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit admin_user_path(@user_1)

      click_on "#{@user_1.username}'s Orders"
      save_and_open_page

      expect(current_path).to eq(admin_user_orders_path(@user_1))

      expect(page).to have_content("Total Items: 8")
      expect(page).to have_content("Grand Total: $32")
      expect(page).to have_link("Order # #{@order_1.id}")
      expect(page).to have_content("Date Order placed: #{@order_1.created_at}")
      expect(page).to have_content("Order Status: #{@order_1.status}")
      expect(page).to have_content("Last Updated: #{@order_1.updated_at}")
    end

    it "can access a specific order show page for a user" do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit admin_user_orders_path(@user_1)
      click_on "Order # #{@order_1.id}"

      expect(current_path).to eq(admin_order_path(@order_1))

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
