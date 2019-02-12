require 'rails_helper'

RSpec.describe 'User sees nav bar' do
  context 'as admin' do
    xit 'allows admin to see all admin links' do
      admin = User.create(username: "Whatever", password: 'yes', role: 2, email: "whatever@gmail.com", address: "larimer", city: "denver", state: "co", zip_code: 80124, active: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit root_path

      expect(page).to have_link("All Users")
      expect(page).to have_link("Dashboard")

      expect(page).to_not have_link("Login")
      expect(page).to_not have_link("Cart")
    end
  end

  context 'as default user' do
    xit "does not allow user to see admin links" do
      user = User.create(username: "Whatever", password: 'yes', role: 0, email: "whatever@gmail.com", address: "larimer", city: "denver", state: "co", zip_code: 80124, active: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit root_path

      expect(page).to have_link("Cart")

      expect(page).to_not have_link("All Users")
      expect(page).to_not have_link("Dashboard")
      expect(page).to_not have_link("Login")
    end

  end

  context 'as a visitor' do
    it 'should see several links on the nav bar' do
      visit root_path

      click_on "Log in"

      expect(current_path).to eq(login_path)
    end
  end
end
