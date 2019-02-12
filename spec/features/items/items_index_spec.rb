require 'rails_helper'

context 'as any kind of user ' do
  describe 'when I visit /spices'  do
      before :each do
        @item_1 = Item.create(name: "Cinnammon",price: 4,image: "http://theepicentre.com/wp-content/uploads/2012/07/cinnamon.jpg",stock: 233, description: "Cinnamon is the inner bark of a tropical evergreen tree. A native of Sri Lanka (formerly Ceylon) the best cinnamon grows along the coastal strip near Colombo. In ancient Egypt cinnamon was used medicinally and as a flavouring for beverages, It was also used in embalming, where body cavities were filled with spiced preservatives.", active: true)
        @item_2 = Item.create(name: "Ginger",price: 5,image: "http://theepicentre.com/wp-content/uploads/2012/07/ginger.jpg",stock: 36, description: "Ginger is native to India and China. It takes its name from the Sanskrit word stringa-vera, which means “with a body like a horn”, as in antlers.It has been important in Chinese medicine for many centuries, and is mentioned in the writings of Confucius. Although often called “ginger root” it is actually a rhizome. It is available in various forms, the most common of which are Whole raw roots, generally referred to as fresh ginger. Whole fresh roots provide the freshest taste.", active: true)
        @item_3 = Item.create(name: "Mustard",price: 3,image: "http://theepicentre.com/wp-content/uploads/2012/07/mustardseed.jpg",stock: 98, description: "It was the condiment, not the plant, that was originally called mustard. The condiment got its name because it was made by grinding the seeds of what was once called the senvy plant into a paste and mixing it with must (an unfermented wine). Mustard is one of the oldest spices and one of the most widely used. The Chinese were using it thousands of years ago and the ancient Greeks considered it an everyday spice.", active: false)
      end
      it 'displays all items in the system except disabled items' do

        visit items_path

          within "#item-#{@item_1.id}" do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content("Price: #{@item_1.price}")
        expect(page).to have_xpath('//img[@src="http://theepicentre.com/wp-content/uploads/2012/07/cinnamon.jpg"]')
        expect(page).to have_content("Stock: #{@item_1.stock}")
        expect(page).to have_content(@item_1.description)

        expect(page).to_not have_content("Stock: #{@item_2.stock}")
        expect(page).to_not have_content(@item_3.description)
        end

        expect(page).to have_content("Stock: #{@item_2.stock}")
        expect(page).to_not have_content(@item_3.description)
      end
  end
end
