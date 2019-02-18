require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'class methods' do
    it '.select_active' do
      user = create(:user, role: 1)
      item_1 = create(:item, active: true, user: user)
      item_2 = create(:item, active: false, user: user)
      item_3 = create(:item, active: true, user: user)
      expect(Item.select_active.count).to eq(2)
    end

    it '.top_five' do
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

      expect(Item.top_five).to eq([item_5, item_3, item_2, item_4, item_1])
      end
  end
end
