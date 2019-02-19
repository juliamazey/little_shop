require 'rails_helper'

RSpec.describe "admin can see merchant's dashboard" do
  context 'as an admin user' do
    before :each do
      @admin = create(:user, role: 2)
      @merchant_1 = create(:user, role: 1)
      @merchant_2 = create(:user, role: 1, active: false)
    end

    it "can visit merchant's index page and enable/disable" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit admin_merchants_path

      expect(page).to have_link(@merchant_1.username)
      expect(page).to have_content(@merchant_1.city)
      expect(page).to have_content(@merchant_2.state)
      expect(page).to have_content(@merchant_2.state)

      within "#merchant-#{@merchant_1.id}" do
      click_on ("Disable")
      end
      expect(current_path).to eq(admin_users_path)
      expect(page).to have_content("This user is now inactive.")

      visit admin_merchants_path

      within "#merchant-#{@merchant_2.id}" do
      click_on "Enable"
      end
      expect(current_path).to eq(admin_users_path)
      expect(page).to have_content("This user is now active.")
    end

    it "can access a merchant's dashboard through merchants index page" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit admin_merchants_path

      click_on "#{@merchant_1.username}"

      expect(current_path).to eq(admin_merchant_path(@merchant_1))

      expect(page).to have_content(@merchant_1.username)
      expect(page).to have_content(@merchant_1.email)
      expect(page).to have_content(@merchant_1.address)
      expect(page).to have_content(@merchant_1.city)
      expect(page).to have_content(@merchant_1.state)
      expect(page).to have_content(@merchant_1.zip_code)
    end
  end
end
