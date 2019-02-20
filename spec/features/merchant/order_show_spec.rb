require 'rails_helper'

RSpec.describe 'As a merchant' do
  before :each do
    @merchant_1 = create(:user, role: 1)
    @merchant_2 = create(:user, role: 1)
    @user_1 = create(:user, role: 0)

    @item_1 = create(:item, active: true, user: @merchant_1)
    @item_2 = create(:item, active: true, user: @merchant_1)
    @item_3 = create(:item, active: true, user: @merchant_2)
    @item_4 = create(:item, active: false, user: @merchant_1)
    @item_5 = create(:item, active: true, user: @merchant_1, stock: 1)
    @item_6 = create(:item, active: true, user: @merchant_1)

    @order_1 = create(:order, user: @user_1)

    @order_item_1 = create(:order_item, item: @item_1, order: @order_1)
    @order_item_2 = create(:order_item, item: @item_2, order: @order_1, fulfilled: true)
    @order_item_3 = create(:order_item, item: @item_3, order: @order_1)
    @order_item_4 = create(:order_item, item: @item_5, order: @order_1)
  end

  describe 'When I visit an order show page from my dashboard' do
    it "shows order's information" do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)

      visit merchant_dashboard_order_path(@order_1)

      expect(page).to have_content(@user_1.username)
      expect(page).to have_content(@user_1.address)

      expect(page).to_not have_content(@item_3.name)

      within "#item-#{@item_1.id}" do
        expect(page).to have_xpath('//img[@src="http://theepicentre.com/wp-content/uploads/2012/07/cinnamon.jpg"]')
        expect(page).to have_content("Price: $#{@item_1.price}")
        expect(page).to have_content("Quantity purchased: #{@order_item_1.order_quantity}")
        expect(page).to_not have_content(@item_2.name)
        click_on "#{@item_1.name}"
        expect(current_path).to eq(merchant_item_path(@item_1))
      end
    end
  end

  it 'fulfills part of an order' do

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)

    visit merchant_dashboard_order_path(@order_1)

    within "#item-#{@item_1.id}" do
      click_on("Fulfill")
    end
    expect(page).to have_content("You have fulfilled the item")
    expect(page).to have_content("Already fulfilled")

    within "#item-#{@item_2.id}" do
      expect(page).to have_content("Already fulfilled")
      expect(page).to_not have_content("Fulfill")
    end

    within "#item-#{@item_5.id}" do
      expect(page).to_not have_content("Fulfill")
    end
  end

  it 'cannot fulfil order if not enough stock' do

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)

    visit merchant_dashboard_order_path(@order_1)

    within "#notice" do
      expect(page).to have_content("You don't have enough items in inventory")
    end
  end

  it 'changes order status if all items fulfilled' do

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)

    order = create(:order, user: @user_1)

    item_1 = create(:item, active: true, user: @merchant_1)
    item_2 = create(:item, active: true, user: @merchant_1)

    order_item_1 = create(:order_item, item: item_1, order: order, fulfilled: true)
    order_item_2 = create(:order_item, item: item_2, order: order)

    visit merchant_dashboard_order_path(order)

    expect(order.status).to eq("pending")

    within "#item-#{item_2.id}" do
      click_on("Fulfill")
    end
    expect(@user_1.orders.last.status).to eq("shipped")

  end
end
