require 'rails_helper'

RSpec.describe "As a registered user" do
  context "When I visit my own profile page" do
    it "should see all of my profile data, except my password" do
      user_1 = create(:user)

      visit user_path(user_1)

      expect(page).to have_content("#{user_1.username}")
      expect(page).to have_content("#{user_1.email}")
      expect(page).to_not have_content("#{user_1.password}")
      expect(page).to_not have_content("#{user_1.password_digest}")
      expect(page).to have_link ("Edit My Profile")
    end
  end
end


# And I see a link to edit my profile data
