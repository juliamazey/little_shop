require 'rails_helper'
RSpec.describe OrderItem, type: :model do
  before :each do
    @merchant_1 = create(:user, role: 1)
    @merchant_2 = create(:user, role: 1, created_at: "Sun, 16 Feb 2019 23:09:01 UTC +00:00")
    @merchant_3 = create(:user, role: 1)
    @merchant_4 = create(:user, role: 1)
    @merchant_5 = create(:user, role: 1, active: false)
    @item_1 = create(:item, active: true, user: @merchant_1, stock: 50)
    @item_2 = create(:item, active: true, user: @merchant_1, stock: 50)
    @item_3 = create(:item, active: true, user: @merchant_2, stock: 50)
    @item_4 = create(:item, active: true, user: @merchant_2, stock: 50)
    @item_5 = create(:item, active: true, user: @merchant_4, stock: 50)
    @item_6 = create(:item, active: true, user: @merchant_4, stock: 50)
    @item_7 = create(:item, active: true, user: @merchant_3, stock: 50)
    @user_1 = create(:user, city: "Atlanta", state: "georgia")
    @user_2 = create(:user, city: "denver", state: "colorado")
    @user_3 = create(:user, city: "saint paul", state: "minnesota")
    @user_4 = create(:user, city: "new york", state: "new york")
    @order_1 = create(:order, user_id: @user_1.id)
    @order_2 = create(:order, user_id: @user_1.id)
    @order_3 = create(:order, user_id: @user_1.id)# Atlanta, 4 orders
    @order_4 = create(:order, user_id: @user_2.id)
    @order_5 = create(:order, user_id: @user_2.id)# denver, 2 orders
    @order_6 = create(:order, user_id: @user_3.id)
    @order_7 = create(:order, user_id: @user_3.id)# st paul, 2 orders
    @order_8 = create(:order, user_id: @user_4.id)# new york, 1 order
    @order_item_1 = create(:order_item, order: @order_1, item: @item_1, order_quantity: 40)# 160
    @order_item_7 = create(:order_item, order: @order_4, item: @item_1)# 16
    @order_item_15 = create(:order_item, order: @order_8, item: @item_1)# 16
    @order_item_2 = create(:order_item, order: @order_1, item: @item_2, order_quantity: 35)# 140
    @order_item_8 = create(:order_item, order: @order_4, item: @item_2, created_at: "Sun, 13 Feb 2019 23:09:01 UTC +00:00", updated_at: "Sun, 19 Feb 2019 23:09:01 UTC +00:00")# 16
    @order_item_11 = create(:order_item, order: @order_6, item: @item_2)# 16
    @order_item_16 = create(:order_item, order: @order_8, item: @item_2)# 16
    #merchant 1 - total revenue = 380
    @order_item_3 = create(:order_item, order: @order_2, item: @item_3, order_quantity: 32)# 128
    @order_item_9 = create(:order_item, order: @order_5, item: @item_3)# 16
    @order_item_12 = create(:order_item, order: @order_6, item: @item_3)# 16
    @order_item_17 = create(:order_item, order: @order_8, item: @item_3)# 16
    @order_item_4 = create(:order_item, order: @order_2, item: @item_4, order_quantity: 30)# 120
    @order_item_10 = create(:order_item, order: @order_5, item: @item_4, order_quantity: 10)# 40
    @order_item_18 = create(:order_item, order: @order_8, item: @item_4)# 16
    @order_item_13 = create(:order_item, order: @order_7, item: @item_4)# 16
    #merchant 2 - total revenue = 368
    @order_item_5 = create(:order_item, order: @order_3, item: @item_5, order_quantity: 28)# 112
    @order_item_14 = create(:order_item, order: @order_7, item: @item_5, created_at: "Sun, 16 Feb 2019 23:09:01 UTC +00:00", updated_at: "Sun, 19 Feb 2019 23:09:01 UTC +00:00")# 16
    @order_item_19 = create(:order_item, order: @order_8, item: @item_5)# 162
    @order_item_6 = create(:order_item, order: @order_3, item: @item_6, order_quantity: 20)# 80
    # merchant 4 - total revenue = 224
    @order_item_6 = create(:order_item, order: @order_3, item: @item_7, order_quantity: 20, created_at: "Sun, 10 Feb 2019 23:09:01 UTC +00:00", updated_at: "Sun, 19 Feb 2019 23:09:01 UTC +00:00")# 80
    # merchant 3 - total revenue = 80
  end
  describe 'relationships' do
    it { should belong_to :order }
    it { should belong_to :item }
  end

  describe 'class methods' do
    it "can return 3 of the biggest_orders" do
      order_items = OrderItem.biggest_orders
      # expect(order_items.count).to eq(3)
    end
  end
end
