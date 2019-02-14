require 'rails_helper'

RSpec.describe "item show page", type: :feature do
  describe "when a visitor visits the item show page" do
    it "shows all the information for the item" do
      @spice_1 = create(:item, active: true)
      visit item_path(@spice_1)

      within ".item_information"
      expect(page).to have_content("Name: #{@spice_1.name}")
      expect(page).to have_content("Description: #{@spice_1.description}")
      expect(page).to have_content("Merchant: #{@spice_1.user.username}")
      expect(page).to have_content("Price: #{@spice_1.price}")
      expect(page).to have_content("Amount available: #{@spice_1.stock}")
      expect(page).to have_css("img[src*='#{@spice_1.image}']")
      expect(page).to have_content("Average time to fufill the order: ####")
    end

    context "the viewer is a visitor or registered user" do
      it "shows a link to add item to the cart" do
        @spice_1 = create(:item, active: true)

        visit item_path(@spice_1)

        expect(page).to have_link("Add Item to Cart")

        @user = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        expect(page).to have_link("Add Item to Cart")
      end
    end

    context "the viewer is a merchant or and admin" do
      it "does not shows a link to add item to the cart" do
        @user2 = create(:user, role: 1)
        @spice_1 = create(:item, active: true)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user2)

        visit item_path(@spice_1)

        expect(page).to_not have_link("Add Item to Cart")

        @user2 = create(:user, role: 2)

        visit item_path(@spice_1)
        expect(page).to_not have_link("Add Item to Cart")
      end
    end
  end
end
