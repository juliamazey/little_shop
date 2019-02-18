require 'rails_helper'

RSpec.describe 'User sees nav bar' do
  before :each do
    @user = create(:user, role: 1)
    @item_1 = create(:item, active: true)
    @item_2 = create(:item, active: true)
    @item_3 = create(:item, active: false)
  end

  context 'as admin' do
    it 'allows admin to see all admin links' do
      admin = create(:user, role: 2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit root_path

      expect(page).to have_link("All Users")
      expect(page).to have_link("Dashboard")
      expect(page).to have_link("Log Out")
      expect(page).to_not have_link("Log In")
      expect(page).to_not have_link("Orders")
      expect(page).to_not have_link("Cart")
      expect(page).to_not have_link("My Orders")
    end
  end


  context 'as a visitor' do
    it 'should see several links on the nav bar' do
      visit root_path

      click_on 'Log In'
      expect(current_path).to eq(login_path)
      click_on 'Home'
      expect(current_path).to eq(root_path)
      click_on 'Spices'
      expect(current_path).to eq(items_path)
      click_on 'Merchants'
      expect(current_path).to eq(merchants_path)
      click_on 'Register'
      expect(current_path).to eq(new_user_path)
    end
    it "just see a message confirming the item was added to the cart" do
      visit items_path

      within "#item-#{@item_1.id}" do
        click_on "Add to Cart"
      end
      expect(page).to have_content("Item added to cart!")
    end
  end

  it 'shows total number of items in cart' do

    visit items_path
    expect(page).to have_content("Cart: 0")
    within "#item-#{@item_1.id}" do
      click_on "Add to Cart"
    end
    expect(page).to have_content("Cart: 1")
  end

  context 'as a registered user' do
    it 'shows some links on the nav bar' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      expect(page).to have_link("Home")
      expect(page).to have_link("Spices")
      expect(page).to have_link("Merchants")
      expect(page).to have_link("My Profile")
      expect(page).to have_link("My Orders")
      expect(page).to have_link("Log Out")
      expect(page).to have_link("My Orders")
      expect(page).to have_content("Logged in as #{user.username}")

      expect(page).to_not have_link("Log In")
      expect(page).to_not have_link("Register")
    end

  end

  context 'as a merchant' do
    it 'shows some links on the nav bar' do
      user = create(:user, role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      expect(page).to have_link("Home")
      expect(page).to have_link("Spices")
      expect(page).to have_link("Merchants")
      expect(page).to have_link("Log Out")
      click_on 'Dashboard'
      expect(current_path).to eq(merchant_dashboard_path(user))

      expect(page).to_not have_link("Log In")
      expect(page).to_not have_link("Cart: 0")
      expect(page).to_not have_link("Register")

    end
  end
end
