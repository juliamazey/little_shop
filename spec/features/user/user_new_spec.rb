require 'rails_helper'

RSpec.describe "user registration form" do
  it "creates a new user" do

    visit new_user_path

    fill_in "Username", with: "Posh"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"
    fill_in "Address", with: "test"
    fill_in "City", with: "test"
    fill_in "State", with: "test"
    fill_in "Zip code", with: 12345
    fill_in "Email", with: "test"

    click_on "Create User"

    new_user = User.last

    expect(page).to have_content("Welcome, #{new_user.username}")
  end

  it "shows a flash message if info is missing" do

    visit new_user_path

    fill_in "Username", with: "Posh"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"
    fill_in "Address", with: "test"
    fill_in "City", with: "test"
    fill_in "State", with: "test"
    fill_in "Zip code", with: 12345

    click_on "Create User"

    expect(page).to have_content("All fields are required")
    expect(current_path).to eq(new_user_path)
  end


    it "shows a flash message if passwords are the same" do

      visit new_user_path

      fill_in "Username", with: "Posh"
      fill_in "Password", with: "test"
      fill_in "Password confirmation", with: "test2"
      fill_in "Address", with: "test"
      fill_in "City", with: "test"
      fill_in "State", with: "test"
      fill_in "Zip code", with: 12345
      fill_in "Email", with: "test"

      click_on "Create User"

      expect(page).to have_content("Password confirmation failed")
      expect(current_path).to eq(new_user_path)
    end

    it "shows a flash message if email is not unique" do
      user = create(:user)
      visit new_user_path

      fill_in "Username", with: "Posh"
      fill_in "Password", with: "test"
      fill_in "Password confirmation", with: "test"
      fill_in "Address", with: "test"
      fill_in "City", with: "test"
      fill_in "State", with: "test"
      fill_in "Zip code", with: 12345
      fill_in "Email", with: "test1@mail.com"

      click_on "Create User"

      expect(page).to have_content("That email is already in use")
      expect(current_path).to eq(new_user_path)
    end

end
