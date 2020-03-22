require 'rails_helper'

RSpec.describe "As a visitor,", type: :feature do
  before :each do
    @shelter_1 = Shelter.create(
          name: "Denver Animal Shelter",
          address: "1241 W Bayaud Ave",
          city: "Denver",
          state: "CO",
          zip: "80223"
        )


    @shelter_2 = Shelter.create(
                          name: "Denver Animal Shelter",
                          address: "1241 W Bayaud Ave",
                          city: "Denver",
                          state: "CO",
                          zip: "80223"
                        )


    @pet_1 = @shelter_1.pets.create(
          image: "/images/meatball.jpg",
          name: "Meatball",
          description: "Trying his best",
          age: 1,
          sex: "Male",
          adoption_status: "adoptable"
        )

    @pet_2 = @shelter_1.pets.create(
          image: "/images/hector.jpg",
          name: "Hector",
          description: "Trying to kill you",
          age: 3,
          sex: "Male",
          adoption_status: "pending adoption"
        )
  end

  it " when I visit /pets,
  then I can see each pet in the system and their information" do
    visit '/pets'

    expect(page).to have_css("img[src*='meatball.jpg']")
    expect(page).to have_content("Meatball")
    expect(page).to have_content(1)
    expect(page).to have_content("Male")
    expect(page).to have_content("Denver Animal Shelter")

    expect(page).to have_css("img[src*='hector.jpg']")
    expect(page).to have_content("Hector")
    expect(page).to have_content(3)
    expect(page).to have_content("Male")
  end

  it "when I visit /shelters/:shelter_id/pets,
  then I see each pet that can be adopted from that shelter
  along with its info" do

    visit "/shelters/#{@shelter_1.id}/pets"

    expect(page).to have_css("img[src*='meatball.jpg']")
    expect(page).to have_content("Meatball")
    expect(page).to have_content(1)
    expect(page).to have_content("Male")

    expect(page).not_to have_css("img[src*='hector.jpg']")
    expect(page).not_to have_content("Hector")
  end

  it "when I visit /pets/:id
  then I see the pet with that id and their information" do
    visit "/pets/#{@pet_1.id}"

    expect(page).to have_css("img[src*='meatball.jpg']")
    expect(page).to have_content("Meatball")
    expect(page).to have_content("Trying his best")
    expect(page).to have_content(1)
    expect(page).to have_content("Male")
    expect(page).to have_content("adoptable")
  end
end


# User Story 9, Pet Show
#
# As a visitor
# When I visit '/pets/:id'
# Then I see the pet with that id including the pet's:
# - image
# - name
# - description
# - approximate age
# - sex
# - adoptable/pending adoption status
