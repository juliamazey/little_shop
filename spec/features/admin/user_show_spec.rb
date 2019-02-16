require 'rails_helper'

RSpec.describe 'As and admin' do
  context "when I visit a user's profile page" do
    it "should see all the user info that a user would see" do
      user_1 = create(:user)
      admin = create(:user, role: 2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_user_path(user_1)

      expect(page).to have_content("#{user_1.username}")
      expect(page).to have_content("#{user_1.email}")
      expect(page).to have_content("#{user_1.address}")
      expect(page).to have_content("#{user_1.city}")
      expect(page).to have_content("#{user_1.state}")
      expect(page).to have_content("#{user_1.zip_code}")

      expect(page).to_not have_content("#{user_1.password}")
      expect(page).to_not have_content("#{user_1.password_digest}")
      expect(page).to have_link ("Edit This Profile")
    end
  end
end
