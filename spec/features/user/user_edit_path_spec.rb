require 'rails_helper'

describe "when a registered user visits their profile page" do
  before :each do
    @user = create(:user)
  end

  describe "and clicks on a link to edit their profile data" do
    it "shows a form like a registration page" do
      visit edit_user_path(@user)

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

      fill_in "Username: #{@user.username}", with: "Mickey Mouse"
      fill_in "Email: #{@user.email}", with: "mouse@disney.com"
      fill_in "Address: #{@user.address}", with: "123 Main Street"
      fill_in "City: #{@user.city}", with: "Lake Buena Vista"
      fill_in "State: #{@user.state}", with: "FL"
      fill_in "Zip Code: #{@user.zip_code}", with: "32911"

      click_on "Submit"

      expect(current_path).to eq(user_path(@user))
    end
  end

  describe "after submitting my updated information" do
    it "shows me my new info and a flash message" do
      visit edit_user_path(@user)

      fill_in "Username: #{@user.username}", with: "Mickey Mouse"
      fill_in "Email: #{@user.email}", with: "mouse@disney.com"
      fill_in "Address: #{@user.address}", with: "123 Main Street"
      fill_in "City: #{@user.city}", with: "Lake Buena Vista"
      fill_in "State: #{@user.state}", with: "FL"
      fill_in "Zip Code: #{@user.zip_code}", with: "32911"
      fill_in "Password:", with: "minniemouse"

      click_on "Submit"

      expect(page).to have_content("Username: Mickey Mouse")
      expect(page).to have_content("Email: mouse@disney.com")
      expect(page).to have_content("Address: 123 Main Street")
      expect(page).to have_content("City: Lake Buena Vista")
      expect(page).to have_content("State: FL")
      expect(page).to have_content("Zip Code: 32911")
    end
  end
end
