# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "csv"
require "open-uri"

puts "Destroying All"
User.destroy_all

puts "Creating Users..."
User.create(first_name: "boris", last_name: "johnson", email: "boris@test.com", password: "password")
User.create(first_name: "tom", last_name: "cruise", email: "tom@test.com", password: "password")
User.create(first_name: "morgan", last_name: "freeman", email: "morgan@test.com", password: "password")
User.create(first_name: "alfie", last_name: "hiscox", email: "alfie@test.com", password: "password")
User.create(first_name: "kurt", last_name: "mcdonald", email: "kurt@test.com", password: "password")

addresses = ["1 Snowden Street, London", "50-52 Old Brompton Rd, South Kensington, London", "61-65 Kensington Church St, Kensington, London", "112/118 Kingsland Rd, Hackney, London", "17B Kingsland Rd, Hackney, London",]
puts "Creating Stores"
Store.create(address: addresses[1], name: "Boris's Bakery", description: Faker::Restaurant.description, user: User.first, tag_list: "Breakfast") 
Store.create(address: addresses[2], name: "Tom's Kitchen", description: Faker::Restaurant.description, user: User.second, tag_list: "Breakfast")
Store.create(address: addresses[3], name: "Club Morgan", description: Faker::Restaurant.description, user: User.find_by(first_name: "morgan"), tag_list: ["Lunch", "Dinner"])
Store.create(address: addresses[4], name: "Kurts Grocery Store", description: Faker::Restaurant.description, user: User.last, tag_list: ["Breakfast", "Lunch", "Dinner"])
Store.create(address: addresses[0], name: "Alfie's Breakfast Cafe", description: Faker::Restaurant.description, user: User.find_by(first_name: "alfie"), tag_list: "Breakfast")

# Store.all.each do |store|
#   puts "Adding items to store"
#   6.times do
#     puts "Item Added"
#     Item.create(store: store, name: Faker::Food.fruits, price: rand(10), discounted_price: rand(5))
#   end
# end

filepath = Rails.root.join('db', 'seeds.csv')
csv_options = {headers: :first_row}

CSV.foreach(filepath, csv_options) do |row|
  store = Store.find_by(name: row["store_name"])
  file = URI.open(row["img_url"])
  item = Item.new(store: store, name: row["name"],price: row["price"], discounted_price: row["discounted_price"]) 
  item.photo.attach(io: file, filename: "#{item.id}-img.jpg", content_type: "image/jpg")
  item.save
  puts "created item"
end











