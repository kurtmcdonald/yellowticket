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
User.create(first_name: "boris", last_name: "johnson", email: "boris@mail.com", password: "password", owner: true)
User.create(first_name: "tom", last_name: "cruise", email: "tom@mail.com", password: "password", owner: true)
User.create(first_name: "morgan", last_name: "freeman", email: "morgan@mail.com", password: "password", owner: true)
User.create(first_name: "alfie", last_name: "hiscox", email: "alfie@mail.com", password: "password", owner: true)
User.create(first_name: "kurt", last_name: "mcdonald", email: "kurt@mail.com", password: "password", owner: true)

addresses = ["1 Snowden Street, London", "50-52 Old Brompton Rd, South Kensington, London", "195 Hackney Rd, Hackney, London", "112/118 Kingsland Rd, Hackney, London", "17B Kingsland Rd, Hackney, London",]
puts "Creating Stores"
boris = Store.create(address: addresses[1], name: "Boris's Bakery", description: 'Boris Bakery is an American-style pastry kitchen established in 2004 to bring the bona fide taste of American home eating to London.', user: User.first, tag_list: "Breakfast")
boris.photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'bakery.jpg')), filename: 'bakery.jpg', content_type: 'image/jpg')
tom = Store.create(address: addresses[2], name: "Tom's Kitchen", description: 'Set in a townhouse on the former site of The Blenheim pub, Tom’s Kitchen Hackney serves comfort food favourites and seasonal specials in a relaxed and informal environment, from breakfast to dinner.', user: User.second, tag_list: ["Breakfast", "Lunch", "Dinner"])
tom.photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'tom.jpg')), filename: 'tom.jpg', content_type: 'image/jpg')
morgan = Store.create(address: addresses[3], name: "Club Morgan", description: 'Club Morgans provides an exceptional dining experience that satisfies our guests’ grown-up tastes by being a Cut-Above in everything we do.', user: User.find_by(first_name: "morgan"), tag_list: ["Lunch", "Dinner"])
morgan.photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'morgan.jpg')), filename: 'morgan.jpg', content_type: 'image/jpg')
kurt = Store.create(address: addresses[4], name: "Mac’s Grocery Store", description: 'Mac''s grocery store is a family run business which opened in 1965 and has been serving the local community with the greatest fresh produce anyone could ask for.', user: User.last, tag_list: ["Breakfast", "Lunch"])
kurt.photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'kurt.jpg')), filename: 'kurt.jpg', content_type: 'image/jpg')
alfie = Store.create(address: addresses[0], name: "Alfie's Breakfast Cafe", description: 'A warm and welcoming cafe in the heart of Hackney serving breakfast all day, 7 days a week.', user: User.find_by(first_name: "alfie"), tag_list: "Breakfast")
alfie.photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'alfie.jpg')), filename: 'alfie.jpg', content_type: 'image/jpg')
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











