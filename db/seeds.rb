require 'csv'

Item.destroy_all
User.destroy_all

merchants = [
merchant_1 = User.create(role: 1, username: "Scary Spice", password: "dontbescared", email: "melanie@scary.com", address: "123 Main Street", city: "Malibu", state: "CA", zip_code: 12345, active: true),
merchant_2 = User.create(role: 1, username: "Posh Spice", password: "imextravagant", email: "victoria@beckham.com", address: "345 John Doe Avenue", city: "Hollywood", state: "CA", zip_code: 23456, active: true),
merchant_3 = User.create(role: 1, username: "Sporty Spice", password: "letsplay", email: "melanie@soccerstar.com", address: "456 Uptown Drive", city: "New York City", state: "NY", zip_code: 34567, active: true),
merchant_4 = User.create(role: 1, username: "Ginger Spice", password: "redheadsarethebest", email: "geri@halliwell.com", address: "567 Bel Air Drive", city: "Chicago", state: "IL", zip_code: 45678, active: true),
merchant_5 = User.create(role: 1, username: "Baby Spice", password: "wheresmybottle", email: "emma@popstar.com", address: "678 Hollywoood Boulevard", city: "Vail", state: "CO", zip_code: 56789, active: true),
merchant_6 = User.create(role: 1, username: "Pumpkin Spice", password: "givemealatte", email: "coffeedrinker@starbucks.com", address: "789 Aurora Drive", city: "Seattle", state: "WA", zip_code: 67890, active: true),
merchant_7 = User.create(role: 1, username: "Sara", password: "bananas", email: "leadsinger@banarama.com", address: "890 Hill Drive", city: "Miami", state: "FL", zip_code: 98765, active: true),
merchant_8 = User.create(role: 1, username: "Siobhan", password: "80spopstar", email: "backupsinger@banarama.com", address: "987 Elm Street", city: "Detroit", state: "MI", zip_code: 87654, active: true),
merchant_9 = User.create(role: 1, username: "Keren", password: "girlbandpower", email: "banaramarules@charttoppers.com", address: "876 Laurel Circle", city: "St Louis", state: "MO", zip_code: 76543, active: true),
merchant_10 = User.create(role: 1, username: "Susanna", password: "banglesrule", email: "vocalsuperstar@thebangles.com", address: "765 Sesame Street", city: "Dallas", state: "TX", zip_code: 65432, active: true),
merchant_11 = User.create(role: 1, username: "Debbi", password: "banglesforever", email: "guitars@thebangles.com", address: "654 Capitol Drive", city: "Las Vegas", state: "NV", zip_code: 54321, active: true),
merchant_12 = User.create(role: 1, username: "Vicki", password: "manicmonday", email: "drummer@popsuperstar.com", address: "543 East 22nd Street", city: "Charleston", state: "SC", zip_code: 22334, active: true)
]

lines = CSV.new(File.open('./db/LS.csv'), headers: true, header_converters: :symbol).read
lines.each do |line|

line = line.to_h

merchants.sample.items.create!(line)
end
