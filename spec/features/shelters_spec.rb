require 'rails_helper'

RSpec.describe "as a visitor, when I visit the /shelters page", type: :feature do
  it "then I can visit the shelter index and show all shelter names" do
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

    visit "/shelters"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_2.name)
  end

  it "then I can visit an indexed shelter and see shelter data" do
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

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_1.address)
    expect(page).to have_content(shelter_1.city)
    expect(page).to have_content(shelter_1.state)
    expect(page).to have_content(shelter_1.zip)

    visit "/shelters/#{shelter_2.id}"

    expect(page).to have_content(shelter_2.name)
    expect(page).to have_content(shelter_2.address)
    expect(page).to have_content(shelter_2.city)
    expect(page).to have_content(shelter_2.state)
    expect(page).to have_content(shelter_2.zip)
  end

  it "then I see a link to create a new shelter and can go create a new shelter" do
    visit "/shelters"

    click_link "New Shelter"

    expect(current_path).to eq('/shelters/new')

    fill_in 'Name ', with: "Cat Care Society"
    fill_in 'Address ', with: "5787 W 6th Ave"
    fill_in 'City ', with: "Lakewood"
    fill_in 'State ', with: "CO"
    fill_in 'Zip ', with: "80214"

    click_button "Create Shelter"

    expect(current_path).to eq("/shelters")

    expect(page).to have_content("Cat Care Society")
    expect(page).to have_content("5787 W 6th Ave")
    expect(page).to have_content("Lakewood")
    expect(page).to have_content("CO")
    expect(page).to have_content("80214")
  end
end

# User Story 4, Shelter Creation
#
# As a visitor
# When I visit the Shelter Index page
# Then I see a link to create a new Shelter, "New Shelter"
# When I click this link
# Then I am taken to '/shelters/new' where I  see a form for a new shelter
# When I fill out the form with a new shelter's:
# - name
# - address
# - city
# - state
# - zip
# And I click the button "Create Shelter" to submit the form
# Then a `POST` request is sent to '/shelters',
# a new shelter is created,
# and I am redirected to the Shelter Index page where I see the new Shelter listed.
