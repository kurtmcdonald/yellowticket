# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Destroying All"
User.destroy_all

puts "Creating Users..."
User.create(first_name: "boris", last_name: "johnson", email: "boris@test.com", password: "password")
User.create(first_name: "tom", last_name: "cruise", email: "tom@test.com", password: "password")
User.create(first_name: "morgan", last_name: "freeman", email: "morgan@test.com", password: "password")

addresses = ["1 Snowden Street, London", "50-52 Old Brompton Rd, South Kensington, London", "61-65 Kensington Church St, Kensington, London", "112/118 Kingsland Rd, Hackney, London", "17B Kingsland Rd, Hackney, London"]
puts "Creating Stores"
Store.create(address: addresses[1], name: Faker::Restaurant.name, description: Faker::Restaurant.description, user: User.first)
Store.create(address: addresses[2], name: Faker::Restaurant.name, description: Faker::Restaurant.description, user: User.second)
Store.create(address: addresses[3], name: Faker::Restaurant.name, description: Faker::Restaurant.description, user: User.first)
Store.create(address: addresses[4], name: Faker::Restaurant.name, description: Faker::Restaurant.description, user: User.last)
Store.create(address: addresses[0], name: Faker::Restaurant.name, description: Faker::Restaurant.description, user: User.second)

Store.all.each do |store|
  puts "Adding items to store"
  20.times do
    puts "Item Added"
    Item.create(store: store, name: Faker::Food.fruits, price: rand(10), discounted_price: rand(5))
  end
end
