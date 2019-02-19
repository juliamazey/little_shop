require 'rails_helper'

RSpec.describe 'As and admin' do
  context "when I visit a user's profile page" do
    it "should see all the user info that a user would see" do
      user_1 = create(:user)
      admin = create(:user, role: 2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_user_path(user_1)

      expect(page).to have_content("#{user_1.username}")
      expect(page).to have_content("#{user_1.email}")
      expect(page).to have_content("#{user_1.address}")
      expect(page).to have_content("#{user_1.city}")
      expect(page).to have_content("#{user_1.state}")
      expect(page).to have_content("#{user_1.zip_code}")
      expect(page).to have_content("#{user_1.username}'s Orders")

      expect(page).to_not have_content("#{user_1.password}")
      expect(page).to_not have_content("#{user_1.password_digest}")
      expect(page).to have_link ("Edit This Profile")
    end

    it "should let the admin update the user info" do
      user_1 = create(:user)
      admin = create(:user, role: 2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_user_path(user_1)
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

    it "shows me an error message if the email address is in use" do
      user_1 = create(:user)
      user_2 = create(:user)
      admin = create(:user, role: 2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_user_path(user_1)
      visit  profile_edit_path

      fill_in "user[username]", with: "Mickey Mouse"
      fill_in "user[email]", with: user_2.email
      fill_in "user[password]", with: "test"
      fill_in "user[password_confirmation]", with: "test"

      click_button "Update User"

      expect(current_path).to eq(profile_edit_path)

      expect(page).to have_content("That email address is already in use.")
    end
  end
end
