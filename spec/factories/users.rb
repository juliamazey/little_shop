FactoryBot.define do
  factory :user do
    sequence(:username) {|n| "test user #{n}"}
    password {"password"}
    sequence(:email) {|n| "test#{n}@mail.com"}
    address {"1234 test street"}
    city {"testville"}
    state {"colorado"}
    zip_code {"11111"}
    active {1}
    role {0}
  end
end
