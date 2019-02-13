require 'rails_helper'

RSpec.describe "user registration form" do
  it "creates a new user" do
    visit root_path

    click_on "Register as a User"

    expect(current_path).to eq(new_user_path)

    fill_in "Username", with: "Posh"
    fill_in "Password", with: "test"

    click_on "Create User"

    new_user = User.last

    expect(page).to have_content("Welcome, #{new_user.username}")
  end

end
