require 'rails_helper'

RSpec.describe 'user logout spec' do
  context 'As any type of user' do
    it 'can log out' do
      user = create(:user)
      item = create(:item, active: true)

      visit login_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on "Log in"

      visit items_path

      within "#item-#{item.id}" do
        click_on "Add to Cart"
        click_on "Add to Cart"
      end

      click_on "Log Out"

      expect(current_path).to eq(root_path)

      expect(page).to have_content("You have been logged out")
      expect(page).to have_content("Cart: 0")
    end
  end
end
