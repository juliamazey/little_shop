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

  describe 'instance methods' do
    before :each do
      @merchant_1 = create(:user, role: 1)

      @item_1 = create(:item, user: @merchant_1, stock: 50)

      @order_1 = create(:order, user_id: @merchant_1.id)
      @order_2 = create(:order, user_id: @merchant_1.id)

      @order_item_1 = create(:order_item, order: @order_1, item: @item_1, order_quantity: 10)
      @order_item_2 = create(:order_item, order: @order_2, item: @item_1, order_quantity: 10)
    end
    it '.quantity_sold' do

      expect(@item_1.quantity_sold).to eq(20)
    end

    it '.deducts_stock' do
      quantity = @order_item_1.order_quantity
    
      expect(@item_1.deducts_stock(quantity)).to eq(40)
    end

    it ".average_fulfillment" do
      merchant = create(:user, role: 1)
      user_1 = create(:user, role: 0)
      item_1 = create(:item, active: true, user: merchant)
      order_1 = create(:order, user: user_1, created_at: 5.days.ago, updated_at: 1.day.ago, status: 2)
      order_2 = create(:order, user: user_1, created_at: 6.days.ago, updated_at: 1.day.ago, status: 2)
      order_3 = create(:order, user: user_1, created_at: 4.days.ago, updated_at: 1.day.ago, status: 2)
      order_4 = create(:order, user: user_1, created_at: 7.days.ago, updated_at: 1.day.ago, status: 1)
      order_item_2 = create(:order_item, item: item_1, order: order_1)
      order_item_3 = create(:order_item, item: item_1, order: order_2)
      order_item_4 = create(:order_item, item: item_1, order: order_3)
      orders = item_1.orders

      expect(item_1.average_fulfillment(orders)).to eq(4)
    end
  end
end
