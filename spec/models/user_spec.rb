require 'rails_helper'

RSpec.describe User do
  describe 'roles' do
    it 'can be created as an admin' do
      admin = User.create(username: "Whatever", password: 'yes', role: 1, email: "whatever@gmail.com", address: "larimer", city: "denver", state: "co", zip_code: 80124, active: 1)

      expect(admin.role).to eq("admin")
      expect(admin.admin?).to be_truthy 
    end
  end
end
