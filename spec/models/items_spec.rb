require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "validations"do
  end

  describe "relationships" do
  end

  describe "class methods" do
    describe "item index page statistics" do
      it "shows top 5 most popular items" do
        merchant_1 = Merchant.create(username: "Scary Spice", email: "scary@spicegirls.com", password: "dontbescared", address: "123 Thames Street", city: "London", state: "NY", zip: 12345, role: "merchant", active: 1)
        spice_1 = merchant_1.spice.create(price: 20, name: "cinnamon", stock: 123, description: "3 inch sticks", active: 1, image: "https://www.herbazest.com/imgs/4/2/b/81361/cinnamon.jpg")
        spice_2 = merchant_1.spice.create(price: 30, name: "nutmeg", stock: 84, description: "1 oz jar", active: 1, image: "https://target.scene7.com/is/image/Target/GUEST_437478c8-93de-4ad8-a267-2b651575526d?wid=488&hei=488&fmt=pjpeg")
        spice_3 = merchant_1.spice.create(price: 10, name: "paprika", stock: 69, description: "1.5 oz jar", active: 1, image: "https://www.coopathome.ch/img/produkte/300_300/RGB/3023072_001.jpg?_=1522737592705")
        spice_4 = merchant_1.spice.create(price: 4, name: "tumeric", stock: 12, description: "0.5 oz jar", active: 1, image: "https://shop.coles.com.au/wcsstore/Coles-CAS/images/3/1/6/316354.jpg")
        spice_5 = merchant_1.spice.create(price: 15, name: "allspice", stock: 78, description: "3 oz jar", active: 1, image: "https://shop.coles.com.au/wcsstore/Coles-CAS/images/3/1/6/316310.jpg")
        spice_6 = merchant_1.spice.create(price: 21, name: "cloves", stock: 34, description: "1 oz jar", active: 1, image: "https://shop.coles.com.au/wcsstore/Coles-CAS/images/3/1/6/316321.jpg")
        spice_7 = merchant_1.spice.create(price: 8, name: "fenugreek", stock: 56, description: "1.5 oz jar", active: 1, image: "https://cdn.shopify.com/s/files/1/0196/5448/products/COM_FenugreekGroundORG_1080x.jpeg?v=1547485207")

      end
    end
  end

  describe "instance methods" do
  end

end
