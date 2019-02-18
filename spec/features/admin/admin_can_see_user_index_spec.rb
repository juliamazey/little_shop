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
      expect(page).to have_content("Registration Date: #{@user2.created_at}")
    end
  end

  context 'a regular user' do
    it "should see a 404" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit admin_users_path

      expect(page).to have_content("That page was too spicy")
    end
  end

  context 'as a merchant' do
    it "should see a 404" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)

      visit admin_users_path

      expect(page).to have_content("That page was too spicy")
    end
  end

  context 'as an admin' do
    it 'allows admin to enable a user account' do
      user = create(:user, role: 2)

      visit login_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on "Log in"

      visit admin_users_path
      click_on "Enable"
      expect(page).to have_content("This user is now active.")
      expect(current_path).to eq(admin_users_path)
    end
    it 'allows admin to disable a user account' do
      user = create(:user, role: 2)

      visit login_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on "Log in"

      visit admin_users_path
      within "#user-#{@user.id}" do
        click_on "Disable"
      end
      expect(page).to have_content("This user is now inactive.")
      expect(current_path).to eq(admin_users_path)
    end
  end

end
