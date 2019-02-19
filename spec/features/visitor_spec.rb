require 'rails_helper'
describe 'As a visitor' do
  before :each do
    @user_1 = User.create(username: "jlo5")
    @item_1 = create(:item, active: true)
    @item_2 = create(:item, active: true)
    @item_3 = create(:item, active: false)
  end

  describe 'I see a navigation bar' do
    it 'has a link to return to the welcome / home page of the application ("/")' do
      visit items_path
      expect(page).to have_content("Home")
      click_on "Home"
    end

    it 'has a link to browse all items for sale ("/items")' do
      visit items_path
      expect(page).to have_content("Spices")
      click_on "Spices"
    end

    it 'has a link to see all merchants ("/merchants")' do
      visit items_path
      expect(page).to have_content("Merchants")
      click_on "Merchants"
    end

    it 'has a link to my shopping cart ("/cart")' do
      visit items_path
      expect(page).to have_content("Cart: 0")
      click_on "Cart: 0"
    end

    it 'has a link to log in ("/login")' do
      visit items_path
      expect(page).to have_content("Log In")
      click_on "Log In"
    end

    it 'has a link to the user registration page ("/register")' do
      visit items_path
      expect(page).to have_content("Register")
      click_on "Register"
    end


    # it 'has a count of the items in my cartNext to the shopping cart link' do
    #   visit items_path
    #   expect(page).to have_content("3")
    # end
  end
end
