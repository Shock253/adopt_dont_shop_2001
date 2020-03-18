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
end
