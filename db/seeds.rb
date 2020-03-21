# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

shelter_1 = Shelter.create(
                        name: "MaxFund Dog Shelter",
                        address: "1005 Galapago St",
                        city: "Denver",
                        state: "CO",
                        zip: "80204"
                      )
shelter_2 = Shelter.create(
                        name: "Denver Animal Shelter",
                        address: "1241 W Bayaud Ave",
                        city: "Denver",
                        state: "CO",
                        zip: "80223"
                      )

pet_1 = shelter_1.pets.create(
      image: "/images/meatball.jpg",
      name: "Meatball",
      description: "Trying his best",
      age: 1,
      sex: "Male",
      adoption_status: "Adoptable"
    )

pet_2 = shelter_1.pets.create(
      image: "/images/hector.jpg",
      name: "Hector",
      description: "Trying to kill you",
      age: 3,
      sex: "Male",
      adoption_status: "Pending Adoption"
    )
