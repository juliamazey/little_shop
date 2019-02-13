require 'rails_helper'


RSpec.describe User, type: :model do
  describe "validations" do
    it {should validate_presence_of :email}
    it {should validate_presence_of :password}
    it {should validate_uniqueness_of :email}
  end

  describe 'roles' do
    it 'can be created as an admin' do
      admin = User.create(username: "Whatever", password: 'yes', role: 2, email: "whatever@gmail.com", address: "larimer", city: "denver", state: "co", zip_code: 80124, active: 1)

      expect(admin.role).to eq("admin")
      expect(admin.admin?).to be_truthy
    end

    it "can be created as a default user" do
      user = User.create(username: "Whatever", password: 'yes', role: 0, email: "whatever@gmail.com", address: "larimer", city: "denver", state: "co", zip_code: 80124, active: 1)

      expect(user.role).to eq("default")
      expect(user.default?).to be_truthy
    end

    it "can be created as a merchant" do
      merchant = User.create(username: "Whatever", password: 'yes', role: 1, email: "whatever@gmail.com", address: "larimer", city: "denver", state: "co", zip_code: 80124, active: 1)

      expect(merchant.role).to eq("merchant")
      expect(merchant.merchant?).to be_truthy
    end
  end

  describe "instance methods" do
    it "can test for matching passwords" do
      
    end
  end

end
