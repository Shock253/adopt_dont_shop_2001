require 'rails_helper'

RSpec.describe "as a visitor", type: :feature do
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

  it "when I visit /shelters,
  then I can visit the shelter index and show all shelter names" do
    visit "/shelters"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
  end

  it "then I can visit an indexed shelter and see shelter data" do

    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_1.address)
    expect(page).to have_content(@shelter_1.city)
    expect(page).to have_content(@shelter_1.state)
    expect(page).to have_content(@shelter_1.zip)

    visit "/shelters/#{@shelter_2.id}"

    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_2.address)
    expect(page).to have_content(@shelter_2.city)
    expect(page).to have_content(@shelter_2.state)
    expect(page).to have_content(@shelter_2.zip)
  end

  it "then I see a link to create a new shelter and can go create a new shelter" do
    visit "/shelters"

    click_link "New Shelter"

    expect(current_path).to eq('/shelters/new')

    fill_in 'Name', with: "Cat Care Society"
    fill_in 'Address', with: "5787 W 6th Ave"
    fill_in 'City', with: "Lakewood"
    fill_in 'State', with: "CO"
    fill_in 'Zip', with: "80214"

    click_button "Create Shelter"

    expect(current_path).to eq("/shelters")

    expect(page).to have_content("Cat Care Society")
  end

  it "then I can go to a shelter update page and update a shelter" do
    visit "/shelters/#{@shelter_1.id}"

    click_link 'Update Shelter'

    expect(current_path).to eq "/shelters/#{@shelter_1.id}/edit"

    fill_in 'Name', with: "Cat Care Society"
    fill_in 'Address', with: "5787 W 6th Ave"
    fill_in 'City', with: "Lakewood"
    fill_in 'State', with: "CO"
    fill_in 'Zip', with: "80214"

    click_button "Update Shelter"

    expect(current_path).to eq "/shelters/#{@shelter_1.id}"
    expect(page).to have_content("Cat Care Society")
    expect(page).to have_content("5787 W 6th Ave")
    expect(page).to have_content("Lakewood")
    expect(page).to have_content("CO")
    expect(page).to have_content("80214")
  end

  it "then I can delete a shelter from the database" do
    visit "/shelters/#{@shelter_1.id}"

    click_link 'Delete Shelter'

    expect(current_path).to eq('/shelters')

    expect(page).to have_no_content("MaxFund Dog Shelter")
  end

  it "when I visit the shelter index page,
  I can edit every shelter's info by clicking an edit link" do

    visit '/shelters'

    click_link "Edit", href: "/shelters/#{@shelter_1.id}/edit"

    expect(current_path).to eq "/shelters/#{@shelter_1.id}/edit"

    fill_in 'Name', with: "Cat Care Society"
    fill_in 'Address', with: "5787 W 6th Ave"
    fill_in 'City', with: "Lakewood"
    fill_in 'State', with: "CO"
    fill_in 'Zip', with: "80214"

    click_button "Update Shelter"

    expect(current_path).to eq "/shelters/#{@shelter_1.id}"
    expect(page).to have_content("Cat Care Society")
    expect(page).to have_content("5787 W 6th Ave")
    expect(page).to have_content("Lakewood")
    expect(page).to have_content("CO")
    expect(page).to have_content("80214")
  end

  it "when I visit the shelter index page,
  I can delete each shelter by clicking a delete link" do
    visit "/shelters"

    click_link "Delete", href: "/shelters/#{@shelter_1.id}"

    expect(current_path).to eq('/shelters')

    expect(page).to have_no_content("MaxFund Dog Shelter")
  end

  it "when I visit any shelter show page,
  I can click a link to go to that shelter's pet index page" do
    visit "/shelters/#{@shelter_1.id}"

    click_link "This Shelter's Pets"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")
  end
end


# User Story 21, Shelter Pet Index Link
#
# As a visitor
# When I visit a shelter show page ('/shelters/:id')
# Then I see a link to take me to that shelter's pets page ('/shelters/:id/pets')
