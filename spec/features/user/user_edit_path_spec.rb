require 'rails_helper'

describe "when a registered user visits their profile page" do
  before :each do
    @user = create(:user)
  end

  describe "and clicks on a link to edit their profile data" do
    xit "shows a form like a registration page" do
      visit edit_user_path(@user)
      # save_and_open_page

      expect(page).to have_content("Username: #{@user.username}")
      expect(page).to have_content("Email: #{@user.email}")
      expect(page).to have_content("Address: #{@user.address}")
      expect(page).to have_content("City: #{@user.city}")
      expect(page).to have_content("Zip Code: #{@user.zip_code}")
      expect(page).to have_content("Password:")
      expect(page).to have_content("Submit")
    end
  end

  describe "when I submit my updated information" do
    it "returns me to my profile page" do
      visit edit_user_path(@user)

      fill_in "user[username]", with: "Mickey Mouse"
      fill_in "user[email]", with: "mouse@disney.com"
      fill_in "user[address]", with: "123 Main Street"
      fill_in "user[city]", with: "Lake Buena Vista"
      fill_in "user[state]", with: "FL"
      fill_in "user[zip_code]", with: "32911"

      click_on "Update User"

      expect(current_path).to eq(user_path(@user))
    end
  end

  describe "after submitting my updated information" do
    it "shows me my new info and a flash message" do
      visit edit_user_path(@user)

      fill_in "user[username]", with: "Mickey Mouse"
      fill_in "user[email]", with: "mouse@disney.com"
      fill_in "user[address]", with: "123 Main Street"
      fill_in "user[city]", with: "Lake Buena Vista"
      fill_in "user[state]", with: "FL"
      fill_in "user[zip_code]", with: "32911"
      fill_in "user[password]", with: "test"
      fill_in "user[password_confirmation]", with: "test"

      click_button "Update User"
      # save_and_open_page
      expect(current_path).to eq(user_path(@user))

      visit user_path(@user)
      # save_and_open_page
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
