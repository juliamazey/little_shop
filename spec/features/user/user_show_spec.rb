require 'rails_helper'

RSpec.describe "As a registered user" do
  context "When I visit my own profile page" do
    before :each do
      @user_1 = create(:user)
      @item_1 = create(:item, active: true)
      @item_2 = create(:item, active: true)
    end
    it "should see all of my profile data, except my password" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

      visit profile_path

      expect(page).to have_content("#{@user_1.username}")
      expect(page).to have_content("#{@user_1.email}")
      expect(page).to_not have_content("#{@user_1.password}")
      expect(page).to_not have_content("#{@user_1.password_digest}")
      expect(page).to have_link ("Edit My Profile")
    end

    it 'should see a list of all of my orders' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
      order = create(:order, user_id: @user_1.id)
      order_2 = create(:order, user_id: @user_1.id)

      visit profile_path

      expect(page).to have_link("My Orders")
    end
  end
end
