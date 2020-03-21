require 'rails_helper'

RSpec.describe "As a visitor, when I visit /pets", type: :feature do
  it "then I can see each pet in the system and their information" do
    shelter_1 = Shelter.create(
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

    visit '/pets'

    expect(page).to have_content("Meatball")
    expect(page).to have_content("Trying his best")
    expect(page).to have_content(1)
    expect(page).to have_content("Male")
    expect(page).to have_content("Adoptable")
    expect(page).to have_content("Denver Animal Shelter")


    expect(page).to have_content("Hector")
    expect(page).to have_content("Trying to kill you")
    expect(page).to have_content(3)
    expect(page).to have_content("Male")
    expect(page).to have_content("Pending Adoption")
  end
end



# User Story 7, Pet Index
#
# As a visitor
# When I visit '/pets'
# Then I see each Pet in the system including the Pet's:
# - image
# - name
# - approximate age
# - sex
# - name of the shelter where the pet is currently located
