require 'rails_helper'

RSpec.describe "admin can see merchant's dashboard" do
  context 'as an admin user' do
    it "can see a merchant's dashboard" do
      admin = create(:user, role: 2)
      merchant = create(:user, role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_merchants_path

      click_on "#{merchant.username}"

      expect(current_path).to eq(admin_merchant_path(merchant))

      expect(page).to have_content(merchant.username)
      expect(page).to have_content(merchant.email)
      expect(page).to have_content(merchant.address)
      expect(page).to have_content(merchant.city)
      expect(page).to have_content(merchant.state)
      expect(page).to have_content(merchant.zip_code)
    end
  end
end
