require 'rails_helper'


RSpec.describe User, type: :model do
  before :each do
    @merchant_1 = create(:user, role: 1)
    @merchant_2 = create(:user, role: 1)
    @admin = create(:user, role: 2)
  end
  describe "validations" do
    it {should validate_presence_of :email}
    it {should validate_presence_of :password}
    it {should validate_uniqueness_of :email}
  end

  describe 'roles' do
    it 'can be created as an admin' do

      expect(@admin.role).to eq("admin")
      expect(@admin.admin?).to be_truthy
    end

    it "can be created as a default user" do
      user = User.create(username: "Whatever", password: 'yes', role: 0, email: "whatever@gmail.com", address: "larimer", city: "denver", state: "co", zip_code: 80124, active: 1)

      expect(user.role).to eq("default")
      expect(user.default?).to be_truthy
    end

    it "can be created as a merchant" do

      expect(@merchant_1.role).to eq("merchant")
      expect(@merchant_1.merchant?).to be_truthy
    end
  end

  describe "instance methods" do
    it "can test for matching passwords" do

    end
  end

  describe "class methods" do
    it ".merchants" do
      expect(User.merchants).to eq([@merchant_1, @merchant_2])
    end
  end

end
