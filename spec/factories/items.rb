FactoryBot.define do
  factory :item do
    price { 4 }
    sequence(:name) { |n| "Cinnammon #{n}"}
    image { "http://theepicentre.com/wp-content/uploads/2012/07/cinnamon.jpg" }
    stock { 7 }
    description { "Cinnamon is the inner bark of a tropical evergreen tree. A native of Sri Lanka (formerly Ceylon) the best cinnamon grows along the coastal strip near Colombo. In ancient Egypt cinnamon was used medicinally and as a flavouring for beverages, It was also used in embalming, where body cavities were filled with spiced preservatives." }
    active {false}
    user
  end
end
