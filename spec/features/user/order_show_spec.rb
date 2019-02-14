require 'rails_helper'

RSpec.describe 'As a registered user' do
  context 'when I visit my orders page' do
    it 'displays all my orders' do

      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      item_1 = create(:item, active: true)
      item_2 = create(:item, active: true, stock: 20)

      order_1 = create(:order, users_id: user.id)
      order_2 = create(:order, users_id: user.id, quantity: 6)

      order_items_1 = create(:order_item, item: item_1, order: order_1)
      order_items_2 = create(:order_item, item: item_2, order: order_1)

      order_items_3 = create(:order_item, item: item_2, order: order_2)

      visit profile_orders_path(user)

      within "#order-#{order_1.id}" do

      expect(page).to have_content("Total Items: 10")
      expect(page).to have_content("Grand Total: $40")

      expect(page).to have_link("#{order_1.id}")
      expect(page).to have_content("#{order_1.created_at}")
      expect(page).to have_content("#{order_1.status}")
      expect(page).to have_content("#{order_1.updated_at}")

      expect(page).to_not have_link("#{order_2.id}")
      expect(page).to_not have_content("#{order_2.created_at}")
      expect(page).to_not have_content("#{order_2.updated_at}")
      expect(page).to_not have_content("#{order_2.status}")

      end
    end
  end
end
