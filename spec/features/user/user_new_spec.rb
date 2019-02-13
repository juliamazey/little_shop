require 'rails_helper'

RSpec.describe "user registration form" do
  it "creates a new user" do

    visit new_user_path
    # save_and_open_page

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
    # binding.pry

    expect(page).to have_content("Welcome, #{new_user.username}")
  end

  it "shows a flash message if info is missing" do

    visit new_user_path
    # save_and_open_page

    fill_in "Username", with: "Posh"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"
    fill_in "Address", with: "test"
    fill_in "City", with: "test"
    fill_in "State", with: "test"
    fill_in "Zip code", with: 12345
    # fill_in "Email", with: "test"

    click_on "Create User"

    # new_user = User.last
    # binding.pry

    expect(page).to have_content("All fields are required")
    expect(current_path).to eq(new_user_path)
  end

end
