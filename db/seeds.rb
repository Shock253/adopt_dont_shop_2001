# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

shelters = Shelter.create(
                      [{
                        name: "MaxFund Dog Shelter",
                        address: "1005 Galapago St",
                        city: "Denver",
                        state: "CO",
                        zip: "80204"
                      },{
                        name: "Denver Animal Shelter",
                        address: "1241 W Bayaud Ave",
                        city: "Denver",
                        state: "CO",
                        zip: "80223"
                      }])
