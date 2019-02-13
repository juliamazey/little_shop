# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require_relative '../app/models/merchant.rb'
Merchant.destroy_all
merchant_1 = User.create(role: 2, username: "Scary Spice", password_digest: "dontbescared", email: "melanie@scary.com", address: "123 Main Street", city: "Malibu", state: "CA", zip_code: 12345, active: 1)
merchant_2 = User.create(role: 2, username: "Posh Spice", password_digest: "imextravagant", email: "victoria@beckham.com", address: "345 John Doe Avenue", city: "Hollywood", state: "CA", zip_code: 23456, active: 1)
merchant_3 = User.create(role: 2, username: "Sporty Spice", password_digest: "letsplay", email: "melanie@soccerstar.com", address: "456 Uptown Drive", city: "New York City", state: "NY", zip_code: 34567, active: 1)
merchant_4 = User.create(role: 2, username: "Ginger Spice", password_digest: "redheadsarethebest", email: "geri@halliwell.com", address: "567 Bel Air Drive", city: "Chicago", state: "IL", zip_code: 45678, active: 1)
merchant_5 = User.create(role: 2, username: "Baby Spice", password_digest: "wheresmybottle", email: "emma@popstar.com", address: "678 Hollywoood Boulevard", city: "Vail", state: "CO", zip_code: 56789, active: 1)
merchant_6 = User.create(role: 2, username: "Pumpkin Spice", password_digest: "givemealatte", email: "coffeedrinker@starbucks.com", address: "789 Aurora Drive", city: "Seattle", state: "WA", zip_code: 67890, active: 1)
merchant_7 = User.create(role: 2, username: "Sara", password_digest: "bananas", email: "leadsinger@banarama.com", address: "890 Hill Drive", city: "Miami", state: "FL", zip_code: 98765, active: 1)
merchant_8 = User.create(role: 2, username: "Siobhan", password_digest: "80spopstar", email: "backupsinger@banarama.com", address: "987 Elm Street", city: "Detroit", state: "MI", zip_code: 87654, active: 1)
merchant_9 = User.create(role: 2, username: "Keren", password_digest: "girlbandpower", email: "banaramarules@charttoppers.com", address: "876 Laurel Circle", city: "St Louis", state: "MO", zip_code: 76543, active: 1)
merchant_10 = User.create(role: 2, username: "Susanna", password_digest: "banglesrule", email: "vocalsuperstar@thebangles.com", address: "765 Sesame Street", city: "Dallas", state: "TX", zip_code: 65432, active: 1)
merchant_11 = User.create(role: 2, username: "Debbi", password_digest: "banglesforever", email: "guitars@thebangles.com", address: "654 Capitol Drive", city: "Las Vegas", state: "NV", zip_code: 54321, active: 1)
merchant_12 = User.create(role: 2, username: "Vicki", password_digest: "manicmonday", email: "drummer@popsuperstar.com", address: "543 East 22nd Street", city: "Charleston", state: "SC", zip_code: 22334, active: 1)
