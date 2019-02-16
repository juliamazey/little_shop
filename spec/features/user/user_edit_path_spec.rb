require 'rails_helper'

describe "when a registered user visits their profile page" do
  before :each do
    @user = create(:user)
  end

  describe "after submitting my updated information" do
    it "shows me my new info and a flash message" do
      visit login_path

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_on "Log in"

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

      expect(current_path).to eq(profile_path)

      expect(page).to have_content("Username: Mickey Mouse")
      expect(page).to have_content("Email: mouse@disney.com")
      expect(page).to have_content("Address: 123 Main Street")
      expect(page).to have_content("City: Lake Buena Vista")
      expect(page).to have_content("State: FL")
      expect(page).to have_content("Zip: 32911")
      expect(page).to have_content("User profile updated.")
    end
  end
end
