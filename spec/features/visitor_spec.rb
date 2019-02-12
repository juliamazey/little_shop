require 'rails_helper'
describe 'As a visitor' do
  before :each do
    user_1 = User.create(username: "jlo5")
  end

  describe 'I see a navigation bar' do
    it 'has a link to return to the welcome / home page of the application ("/")' do
      visit user_path
      expect(page).to have_content("Home")
      clik_on "Home", '/'
    end

    it 'has a link to browse all items for sale ("/items")' do
      visit user_path
      expect(page).to have_content("Items")
      clik_on "Items", '/index'
    end

    it 'has a link to see all merchants ("/merchants")' do
      visit user_path
      expect(page).to have_content("Merchants")
      clik_on "Merchants", merchant_index_path
    end

    it 'has a link to my shopping cart ("/cart")' do
      visit user_path
      expect(page).to have_content("Cart")
      clik_on "Cart", '/cart'
    end

    it 'has a link to log in ("/login")' do
      visit user_path
      expect(page).to have_content("Login")
      clik_on "Login", '/login'
    end

    it 'has a link to the user registration page ("/register")' do
      visit user_path
      expect(page).to have_content("Register")
      clik_on "Register", '/register'
    end


    it 'has a count of the items in my cartNext to the shopping cart link' do
      visit user_path
      expect(page).to have_content("3")
    end
  end
end
