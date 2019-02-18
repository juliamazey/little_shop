require 'rails_helper'

RSpec.describe "admin can see merchant's dashboard" do
  context 'as an admin user' do
    it "can see a merchant's dashboard" do
      admin = create(:user, role: 2)
      merchant = create(:user, role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit merchants_path

      click_on "#{merchant.username}"

      expect(current_path).to eq(merchant_dashboard_path(merchant))
      save_and_open_page
      expect(page).to have_content

    end

  end

end
