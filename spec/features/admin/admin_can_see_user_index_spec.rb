require 'rails_helper'

RSpec.describe 'user index page' do
  before :each do
    @user = create(:user)
    @user2 = create(:user, active: false)
    @merchant = create(:user, role: 1)
    @admin = create(:user, role: 2)
  end

  context 'as an admin user' do
    it 'allows an admin to see the user index page' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit admin_users_path

      expect(page).to have_link("#{@user.username}")
      expect(page).to have_link("#{@user2.username}")
      expect(page).to have_button("Disable")
      expect(page).to have_button("Enable")
    end
  end

  context 'a regular user' do
    it "should see a 404" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit admin_users_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  context 'as a merchant' do
    it "should see a 404" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)

      visit admin_users_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
