require 'rails_helper'

RSpec.describe 'User sees nav bar' do
  context 'as admin' do
    it 'allows admin to see all admin links' do
      admin = create(:user, role: 2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit root_path

      expect(page).to have_link("All Users")
      expect(page).to have_link("Dashboard")
      expect(page).to have_link("Logout")
      expect(page).to_not have_link("Log In")
      expect(page).to_not have_link("Orders")
      # expect(page).to_not have_link("Cart")
    end
  end

  context 'as default user' do
    it "i see links associated with registered user" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path
      # expect(page).to have_link("Cart")#("/cart")

      expect(page).to_not have_link("All Users")
      expect(page).to have_link("Profile")
      expect(page).to have_link("Orders")

      # expect(page).to_not have_link("Cart (3)") #count of the items in my cart
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
      expect(current_path).to eq(merchant_users_path)
      click_on 'Register'
      expect(current_path).to eq(new_user_path)
    end
  end
end
