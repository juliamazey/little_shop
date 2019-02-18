require 'rails_helper'

RSpec.describe 'when I visit the login path ' do
  context 'as a visitor' do
    before :each do
      @user = create(:user)
    end
    it 'should have a form to log in, and it authenticates' do

      visit login_path

      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password

      click_on "Log in"
      expect(current_path).to eq(profile_path)
      expect(page).to have_content("Welcome, #{@user.username}")
    end

    it 'cannot log in with bad credentials' do

      visit login_path

      fill_in "Email", with: @user.email
      fill_in "Password", with: "hello"

      click_on "Log in"
      expect(current_path).to eq(login_path)
      expect(page).to have_content("Bad log in credentials")

      fill_in "Email", with: "alo@alo.com"
      fill_in "Password", with: @user.password

      click_on "Log in"
      expect(current_path).to eq(login_path)
      expect(page).to have_content("Bad log in credentials")
    end
  end
end
