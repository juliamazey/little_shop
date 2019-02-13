require 'rails_helper'

RSpec.describe 'when I visit /spices'  do
  context 'as any kind of user ' do
      before :each do
        @item_1 = create(:item, active: true)
        @item_2 = create(:item, active: true)
        @item_3 = create(:item)
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

        # visit items_path

        # find(@item_1.image).click
        # click_on @item_1.image
        # expect(current_path).to eq(item_path(@item_1))
      end

  end
end
