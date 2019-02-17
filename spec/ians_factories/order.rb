FactoryBot.define do
  factory :order, class: Order do
    user
    status { :pending }
  end
  factory :completed_order, parent: :order do
    user
    status { :completed }
  end
  factory :cancelled_order, parent: :order do
    user
    status { :cancelled }
  end
end
