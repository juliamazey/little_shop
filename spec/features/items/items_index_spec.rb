require 'rails_helper'

RSpec.describe 'when I visit /spices'  do
  context 'as any kind of user ' do
      before :each do
        @item_1 = create(:item, active: true)
        @item_2 = create(:item, active: true)
        @item_3 = create(:item)
        @item_4 = create(:item, active: true)
        @item_5 = create(:item, active: true)
        @item_6 = create(:item, active: true)
        @item_7 = create(:item, active: true)
        @item_8 = create(:item, active: true)
        @item_9 = create(:item, active: true)

      end

      it 'displays all items in the system except disabled items' do
        visit items_path

        within "#item-#{@item_1.id}" do

        expect(page).to have_content(@item_1.name)
        expect(page).to have_content("Price: #{@item_1.price}")
        expect(page).to have_xpath('//img[@src="http://theepicentre.com/wp-content/uploads/2012/07/cinnamon.jpg"]')
        expect(page).to have_content("Stock: #{@item_1.stock}")
        expect(page).to have_content(@item_1.user.username)

        expect(page).to_not have_content(@item_2.name)
        expect(page).to_not have_content(@item_3.name)
        end

        expect(page).to have_content(@item_2.name)
        expect(page).to_not have_content(@item_3.name)
      end

      it 'has links for the item name and image' do

        visit items_path

        click_on @item_1.name
        expect(current_path).to eq(item_path(@item_1))

        visit items_path

        find("#image-#{@item_1.id}").click

        expect(current_path).to eq(item_path(@item_1))
      end

      it 'should have a link to add to cart' do
        visit items_path
        within "#item-#{@item_1.id}" do
          expect(page).to have_button("Add to Cart")
        end
      end

      it 'shows top 5 most popular items' do
        merchant_1 = create(:user, role: 1)
        merchant_2 = create(:user, role: 1)

        item_1 = create(:item, user: merchant_1)
        item_2 = create(:item, user: merchant_1)
        item_3 = create(:item, user: merchant_1)
        item_4 = create(:item, user: merchant_1)
        item_5 = create(:item, user: merchant_1)
        item_6 = create(:item, user: merchant_1)
        item_7 = create(:item, user: merchant_2)

        order = create(:order, user_id: merchant_2.id)

        create(:order_item, order: order, item: item_1, order_quantity: 10)
        create(:order_item, order: order, item: item_2, order_quantity: 20)
        create(:order_item, order: order, item: item_3, order_quantity: 30)
        create(:order_item, order: order, item: item_4, order_quantity: 15)
        create(:order_item, order: order, item: item_5, order_quantity: 80)
        create(:order_item, order: order, item: item_6, order_quantity: 9)
        create(:order_item, order: order, item: item_7, order_quantity: 5)

        visit items_path

        within ".top_statistics_block" do
          expect(page).to have_content("Five Most Popular Items:")
          expect(page).to have_content("#{item_5.name}, total quantity sold: #{item_5.quantity_sold}")
          expect(page).to have_content("#{item_3.name}, total quantity sold: #{item_3.quantity_sold}")
          expect(page).to have_content("#{item_2.name}, total quantity sold: #{item_2.quantity_sold}")
          expect(page).to have_content("#{item_4.name}, total quantity sold: #{item_4.quantity_sold}")
          expect(page).to have_content("#{item_1.name}, total quantity sold: #{item_1.quantity_sold}")
        end

        within ".bottom_statistics_block" do
          expect(page).to have_content("Five Least Popular Items:")
          expect(page).to have_content("#{item_7.name}, total quantity sold: #{item_7.quantity_sold}")
          expect(page).to have_content("#{item_6.name}, total quantity sold: #{item_6.quantity_sold}")
          expect(page).to have_content("#{item_1.name}, total quantity sold: #{item_1.quantity_sold}")
          expect(page).to have_content("#{item_4.name}, total quantity sold: #{item_4.quantity_sold}")
          expect(page).to have_content("#{item_2.name}, total quantity sold: #{item_2.quantity_sold}")
        end
      end
  end
end
