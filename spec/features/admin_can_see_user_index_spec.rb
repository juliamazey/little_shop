require 'rails_helper'

RSpec.describe 'user index page' do
  context 'as an admin user' do
    it 'allows an admin to see the user index page' do
      user1 = create(:user)
      user2 = create(:user)
      admin = create(:user, role: 2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_users_path

      expect(page).to have_content("#{user1.username}")
      expect(page).to have_content("#{user2.username}")
    end
  end
end
