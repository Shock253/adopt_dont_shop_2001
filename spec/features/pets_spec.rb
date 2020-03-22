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
          image: "https://external-preview.redd.it/noQNH1z-l-iM70pfcuMat96eW7LPar8HM_oGrIdEnT4.jpg?width=640&crop=smart&auto=webp&s=b19dff5d345bf94eac9a2f6d662591c0213ab239",
          name: "Meatball",
          description: "Trying his best",
          age: 1,
          sex: "Male",
          adoption_status: "adoptable"
        )

    @pet_2 = @shelter_1.pets.create(
          image: "https://upload.wikimedia.org/wikipedia/commons/6/66/An_up-close_picture_of_a_curious_male_domestic_shorthair_tabby_cat.jpg",
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

    expect(page).to have_css("img[src='https://external-preview.redd.it/noQNH1z-l-iM70pfcuMat96eW7LPar8HM_oGrIdEnT4.jpg?width=640&crop=smart&auto=webp&s=b19dff5d345bf94eac9a2f6d662591c0213ab239']")
    expect(page).to have_content("Meatball")
    expect(page).to have_content(1)
    expect(page).to have_content("Male")
    expect(page).to have_content("Denver Animal Shelter")

    expect(page).to have_css("img[src='https://upload.wikimedia.org/wikipedia/commons/6/66/An_up-close_picture_of_a_curious_male_domestic_shorthair_tabby_cat.jpg']")
    expect(page).to have_content("Hector")
    expect(page).to have_content(3)
    expect(page).to have_content("Male")
  end

  it "when I visit /shelters/:shelter_id/pets,
  then I see each pet that can be adopted from that shelter
  along with its info" do

    visit "/shelters/#{@shelter_1.id}/pets"

    expect(page).to have_css("img[src='https://external-preview.redd.it/noQNH1z-l-iM70pfcuMat96eW7LPar8HM_oGrIdEnT4.jpg?width=640&crop=smart&auto=webp&s=b19dff5d345bf94eac9a2f6d662591c0213ab239']")
    expect(page).to have_content("Meatball")
    expect(page).to have_content(1)
    expect(page).to have_content("Male")

    expect(page).not_to have_css("img[src='https://upload.wikimedia.org/wikipedia/commons/6/66/An_up-close_picture_of_a_curious_male_domestic_shorthair_tabby_cat.jpg']")
    expect(page).not_to have_content("Hector")
  end

  it "when I visit /pets/:id
  then I see the pet with that id and their information" do
    visit "/pets/#{@pet_1.id}"

    expect(page).to have_css("img[src='https://external-preview.redd.it/noQNH1z-l-iM70pfcuMat96eW7LPar8HM_oGrIdEnT4.jpg?width=640&crop=smart&auto=webp&s=b19dff5d345bf94eac9a2f6d662591c0213ab239']")
    expect(page).to have_content("Meatball")
    expect(page).to have_content("Trying his best")
    expect(page).to have_content(1)
    expect(page).to have_content("Male")
    expect(page).to have_content("adoptable")
  end

  it "when I visit a shelter pets index page,
  then I see a link to add a new adoptable pet,
  when I click the link, I can create a new pet" do
    visit "/shelters/#{@shelter_1.id}/pets"

    click_link 'Create Pet'

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets/new")

    fill_in 'Image', with: "https://vetmed.illinois.edu/wp-content/uploads/2017/12/pc-keller-hedgehog.jpg"
    fill_in 'Name', with: "Reginald"
    fill_in 'Description', with: "Soft boi"
    fill_in 'Age', with: 2
    fill_in 'Sex', with: "Male"

    click_button "Create Pet"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")

    expect(page).to have_content("Reginald")
    expect(page).to have_css("img[src='https://vetmed.illinois.edu/wp-content/uploads/2017/12/pc-keller-hedgehog.jpg']")

  end
end


# User Story 10, Shelter Pet Creation
#
# As a visitor
# When I visit a Shelter Pets Index page
# Then I see a link to add a new adoptable pet for that shelter "Create Pet"
# When I click the link
# I am taken to '/shelters/:shelter_id/pets/new' where I see a form to add a new adoptable pet
# When I fill in the form with the pet's:
# - image
# - name
# - description
# - approximate age
# - sex ('female' or 'male')
# And I click the button "Create Pet"
# Then a `POST` request is sent to '/shelters/:shelter_id/pets',
# a new pet is created for that shelter,
# that pet has a status of 'adoptable',
# and I am redirected to the Shelter Pets Index page where I can see the new pet listed
