require 'rails_helper'

RSpec.describe "As a visitor" do
  context "when I visit '/merchants'" do
    it "displays all active merchants in the system" do
      @merchant_1 = create(:user, role: 1)
      @merchant_2 = create(:user, role: 1, created_at: "Sun, 16 Feb 2019 23:09:01 UTC +00:00")
      @merchant_3 = create(:user, role: 1)
      @merchant_4 = create(:user, role: 1)
      @merchant_5 = create(:user, role: 1, active: false)

      visit merchants_path

      expect(page).to have_content(@merchant_1.username)
      expect(page).to have_content(@merchant_2.created_at)
      expect(page).to have_content(@merchant_3.city)
      expect(page).to have_content(@merchant_4.state)

      expect(page).to_not have_content(@merchant_5.username)
    end
  end
end
