require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'As a visitor or registered user' do
  before :each do
    @user = create(:user)
    @item = create(:item, active: true)
    @item2 = create(:item, active: true)
  end
  describe 'When I have added items to my cart' do
    it 'sees all items and their attributes' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit items_path
      save_and_open_page
      within "#item-#{@item.id}" do
        click_button "Add to Cart"
      end
      within "#item-#{@item2.id}" do
        click_button "Add to Cart"
      end

      visit cart_path

      within "#item-#{@item.id}" do
        expect(page).to have_content(@item.name)
        expect(page).to have_content(@item.image)
        expect(page).to have_content(@item.user.username)
        expect(page).to have_content("Stock: #{@item.stock}")
        expect(page).to have_content("#{number_to_currency(@item.price)}")
        expect(page).to have_content("Subtotal: #{number_to_currency(@item.price)}")
      end

      within "#item-#{@item2.id}" do
        expect(page).to have_content(@item2.name)
        expect(page).to have_content(@item2.image)
        expect(page).to have_content(@item2.user.username)
        expect(page).to have_content("Stock: #{@item2.stock}")
        expect(page).to have_content("#{number_to_currency(@item2.price)}")
        expect(page).to have_content("Subtotal: #{number_to_currency(@item2.price)}")
      end

      expect(page).to have_content("Grand Total: #{number_to_currency(@item.price + @item2.price)}")

      expect(page).to have_link("Empty Cart")
    end

    it 'click the link to empty my cart' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit cart_path

      expect(page).to have_content(@item.name)
      expect(page).to have_link "Empty Cart"

      visit cart_path

      expect(page).to_not have_content(@item.name)
      expect(page).to have_content("Cart: 0")
    end
  end
end
