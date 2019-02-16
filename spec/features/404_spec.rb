require 'rails_helper'

RSpec.describe 'Users cannot navigate to certain paths' do
  context 'as a visitor' do
    it 'cannot visit certain paths' do
      user = create(:user)
      merchant = create(:user, role: 1)

      visit profile_path(user)

      expect(page).to have_content("That page was too spicy")

      visit merchant_dashboard_path(merchant)

      expect(page).to have_content("That page was too spicy")

      visit admin_users_path

      expect(page).to have_content("That page was too spicy")
    end
  end

  context 'as a user' do
    it 'cannot visit certain paths' do
      user = create(:user)
      merchant = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit merchant_dashboard_path(merchant)

      expect(page).to have_content("That page was too spicy")

      visit admin_users_path

      expect(page).to have_content("That page was too spicy")
    end
  end

  context 'as a merchant' do
    it 'cannot visit certain paths' do
      user = create(:user)
      merchant = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      visit profile_path(user)

      expect(page).to have_content("That page was too spicy")

      visit admin_users_path

      expect(page).to have_content("That page was too spicy")

      visit cart_path

      expect(page).to have_content("That page was too spicy")
    end
  end

end
