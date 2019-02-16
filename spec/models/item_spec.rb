require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'class methods' do
    it 'can select only active items' do
      user = create(:user, role: 1)
      item = create(:item, active: true, user: user)
      item2 = create(:item, active: false, user: user)
      item3 = create(:item, active: true, user: user)
      expect(Item.select_active.count).to eq(2)
    end
  end

end
