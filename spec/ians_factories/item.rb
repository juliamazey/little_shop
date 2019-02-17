FactoryBot.define do
  factory :item do
    association :user, factory: :merchant
    sequence(:name) { |n| "Item Name #{n}" }
    sequence(:description) { |n| "Description #{n}" }
    sequence(:image) { |n| "https://picsum.photos/200/300?image=#{n}" }
    sequence(:price) { |n| ("#{n}".to_i+1)*1.5 }
    sequence(:stock) { |n| ("#{n}".to_i+1)*2 }
    active { true }
  end

  # factory :inactive_item, parent: :item do
  #   association :user, factory: :merchant
  #   sequence(:name) { |n| "Inactive Item Name #{n}" }
  #   active { false }
  # end
end
