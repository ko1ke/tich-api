# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Portfolio.all.delete_all
User.all.delete_all
Ticker.all.delete_all

uid = 'fehyMsvNalfinbrGlUREooQqFyJ3'
email = 'test@test.com'
json_path = File.join(Rails.root, 'db', 'portfolio_seed.json')
sheet = File.read(json_path)

user = User.create!(uid: uid, email: email)
user.create_portfolio!(sheet: JSON.parse(sheet))
ScrapeNasdaq100TickersJob.perform_now

pp '--- 🎉 Scraping result 🎉 ---'
pp Ticker.all.pluck(:symbol, :formal_name)

FetchStockPriceFromSpreadSheetJob.perform_now
