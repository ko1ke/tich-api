# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Portfolio.all.delete_all

dummy_uid = 'fehyMsvNalfinbrGlUREooQqFyJ3'
json_path = File.join(Rails.root, 'db', 'portfolio_seed.json')
sheet = File.read(json_path)
Portfolio.create!(uid: dummy_uid, sheet: JSON.parse(sheet))
