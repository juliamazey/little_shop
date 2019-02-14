require 'rails_helper'

RSpec.describe "As a merhcant" do
  describe "when i visit my dashboard" do
    it "should see my profile data, and can not edit it" do
      merchant = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)
      
      visit merchant_dashboard_path(merchant)

      expect(page).to have_content(merchant.username)
      expect(page).to have_content(merchant.email)
      expect(page).to have_content(merchant.address)
      expect(page).to have_content(merchant.city)
      expect(page).to have_content(merchant.state)
      expect(page).to have_content(merchant.zip_code)

      expect(page).to_not have_link("Edit My Profile")
    end
  end
end
