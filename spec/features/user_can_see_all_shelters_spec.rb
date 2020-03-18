require 'rails_helper'

RSpec.describe "as a visitor", type: :feature do
  it "can visit the shelter index and show all shelter names" do
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

  it "can visit an indexed shelter and see shelter data" do
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
end
