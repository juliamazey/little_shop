require 'rails_helper'

RSpec.describe Order, type: :model do

  describe 'instance methods' do
    it '.total_items' do
      user = create(:user)
      item_1 = create(:item, active: true)
      item_2 = create(:item, active: true, stock: 20)

      order_1 = create(:order, users_id: user.id)
      order_2 = create(:order, users_id: user.id)

      order_items_1 = create(:order_item, item: item_1, order: order_1)
      order_items_2 = create(:order_item, item: item_2, order: order_1)
      order_items_3 = create(:order_item, item: item_2, order: order_2)

      expect(order_1.total_items).to eq(8)
      expect(order_2.total_items).to eq(4)
    end

    it '.grand_total' do
      user = create(:user)
      item_1 = create(:item, active: true)
      item_2 = create(:item, active: true, stock: 20)

      order_1 = create(:order, users_id: user.id)

      order_items_1 = create(:order_item, item: item_1, order: order_1)
      order_items_2 = create(:order_item, item: item_2, order: order_1)

      expect(order_1.grand_total).to eq(32)
    end
  end


end
