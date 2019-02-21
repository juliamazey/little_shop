require 'rails_helper'

RSpec.describe 'user login spec' do
  context 'as a regular user' do
    it 'can log in and is redirected to profile page and cannot visit log in path again' do
      user = create(:user)

      visit login_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on "Log in"

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("You are logged in")

      visit login_path

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("You are already logged in")
    end
  end

  context 'as a merchant' do
    it 'can log in and is redirected to its dashboard page  and cannot visit log in path again' do
      user = create(:user, role: 1)

      visit login_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on "Log in"

      expect(current_path).to eq(merchant_dashboard_path(user))
      expect(page).to have_content("You are logged in")

      visit login_path

      expect(current_path).to eq(merchant_dashboard_path(user))
      expect(page).to have_content("You are already logged in")
    end

  end

  context 'as an admin' do
    it 'can log in and is redirected to the home page  and cannot visit log in path again' do
      user = create(:user, role: 2)

      visit login_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on "Log in"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("You are logged in")

      visit login_path

      expect(current_path).to eq(root_path)
      expect(page).to have_content("You are already logged in")
    end

  end


end
