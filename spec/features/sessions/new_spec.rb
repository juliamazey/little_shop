require 'rails_helper'

RSpec.describe 'As a registered user' do
  context 'when I the login path' do
    it 'should have a form to log in' do
      user = User.create(username: "Whatever", password: 'yes', role: 0, email: "whatever@gmail.com", address: "larimer", city: "denver", state: "co", zip_code: 80124, active: 1)

      visit login_path

      fill_in "email", with: user.email
      fill_in "password", with: user.password

      click_on "Log in"

      expect(current_path).to eq(user_path(user))
      expect(page).to have_content("Welcome, #{user.username}")
    end
  end
end
