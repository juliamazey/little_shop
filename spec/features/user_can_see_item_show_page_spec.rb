require 'rails_helper'

RSpec.describe "item show page", type: :feature do
  describe "when a visitor visits the item show page" do
    it "shows all the information for the item" do
      merchant_1 = User.create(username: "Scary Spice", email: "scary@spicegirls.com", password: "dontbescared", address: "123 Thames Street", city: "London", state: "NY", zip_code: 12345, role: "merchant", active: 1)
      spice_1 = merchant_1.items.create(price: 20.00, name: "cinnamon", stock: 12, description: "3 inch sticks", active: 1, image: "https://www.herbazest.com/imgs/4/2/b/81361/cinnamon.jpg")
# binding.pry
      visit item_path(spice_1)

      within ".item_information"
      expect(page).to have_content("Name: cinnamon")
      expect(page).to have_content("Description: 3 inch sticks")
      expect(page).to have_content("Merchant: Scary Spice")
      expect(page).to have_content("Price: #{spice_1.price}")
      expect(page).to have_content("Amount available: #{spice_1.stock}")
      expect(page).to have_css("img[src*='#{spice_1.image}']")
      expect(page).to have_content("Average time to fufill the order: ####")
    end

    context "the viewer is a visitor or registered user" do
      xit "shows a link to add item to the cart" do
        merchant_1 = User.create(username: "Scary Spice", email: "scary@spicegirls.com", password_digest: "dontbescared", address: "123 Thames Street", city: "London", state: "NY", zip: 12345, role: "merchant", active: 1)
        spice_1 = merchant_1.spice.create(price: 20, name: "cinnamon", stock: 12, description: "3 inch sticks", active: 1, image: "https://www.herbazest.com/imgs/4/2/b/81361/cinnamon.jpg")
        visit "items/#{spice_1.id}"

        expect(page).to have_content("Add Item to Cart")
        expect(page).to have_selector("Add Item to Cart", href: "###cart path link###")
        expect(page).to have_button('Add Item to Cart')
      end
    end
  end
end
