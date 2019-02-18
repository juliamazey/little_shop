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

    describe "when I revisit my cart" do
      it "has functionality to increase an item amount in my cart" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
        visit items_path

        within "#item-#{@item2.id}" do
          click_button "Add to Cart"
        end

        visit cart_path

        within "#item-#{@item2.id}" do
          click_on "Increase Amount"
        end

        within "#item-#{@item2.id}" do
          expect(page).to have_content("Quantity: 2")
        end
      end
    end

    describe "when I revisit my cart and add an item" do
      it "I can't exceed the stock amount" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
        visit items_path

        within "#item-#{@item2.id}" do
          click_button "Add to Cart"
        end

        visit cart_path

        within "#item-#{@item2.id}" do
          6.times do click_on "Increase Amount"
          end
        end
        #7 items in cart at this point
        within "#item-#{@item2.id}" do
          expect(page).to have_content("Quantity: 7")
        end

        within "#item-#{@item2.id}" do
          click_on "Increase Amount"
        end
        #7 items in stock, should not increment quantity to 8
        within "#item-#{@item2.id}" do
          expect(page).to have_content("Quantity: 7")
        end
      end
    end

    describe "when I revisit my cart " do
      it "I can decrease the amount" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
        visit items_path

        within "#item-#{@item2.id}" do
          click_button "Add to Cart"
        end

        visit cart_path

        within "#item-#{@item2.id}" do
          3.times do click_on "Increase Amount"
          end
        end
        #4 items in cart at this point
        within "#item-#{@item2.id}" do
          expect(page).to have_content("Quantity: 4")
        end

        within "#item-#{@item2.id}" do
          click_on "Decrease Amount"
        end
        #should now be a quantity of 3 items
        within "#item-#{@item2.id}" do
          expect(page).to have_content("Quantity: 3")
        end
      end
    end

    describe "when I decrease the amount of an item " do
      it "it is removed from the cart if the new amount is 0" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
        visit items_path

        within "#item-#{@item2.id}" do
          click_button "Add to Cart"
        end

        visit cart_path

        within "#item-#{@item2.id}" do
          click_on "Decrease Amount"
        end
        expect(page).to_not have_selector("#item-#{@item2.id}")
      end
    end


    describe "when I revisit my cart" do
      it "has functionality to remove an item from my cart" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
        visit items_path

        within "#item-#{@item.id}" do
          click_button "Add to Cart"
        end

        within "#item-#{@item2.id}" do
          click_button "Add to Cart"
        end

        visit cart_path

        within "#item-#{@item.id}" do
          click_on "Remove Item #{@item.name}"
        end

          expect(page).to_not have_selector("#item-#{@item.id}")

        within "#item-#{@item2.id}" do
          expect(page).to_not have_content("Quantity: 0")
        end
      end
    end
#story 27
    it 'sees a message that the cart is empty' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit cart_path

      expect(page).to_not have_content(@item.name)
      expect(page).to_not have_link "Empty Cart"
      expect(page).to have_content("Your cart is empty.")
    end

    it 'can empty cart' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit items_path
      within "#item-#{@item.id}" do
        click_on "Add to Cart"
        click_on "Add to Cart"
      end
      within "#item-#{@item2.id}" do
        click_on "Add to Cart"
      end
      visit cart_path

      click_on "Empty Cart"
      expect(page).to_not have_content(@item.name)
      expect(page).to_not have_content(@item2.name)
      expect(page).to have_content("Cart: 0")

      expect(current_path).to eq(cart_path)
    end

    it "cannot checkout if it isn't a user" do
      visit items_path
      within "#item-#{@item.id}" do
        click_on "Add to Cart"
        click_on "Add to Cart"
      end
      within "#item-#{@item2.id}" do
        click_on "Add to Cart"
      end
      visit cart_path

      expect(page).to have_content("You need to have an account to checkout")
      expect(page).to have_link("Click here to register")
      expect(page).to have_link("Click here to log in")

      click_on "Click here to register"
      expect(current_path).to eq(new_user_path)
    end
  end
end
