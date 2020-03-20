require 'rails_helper'

RSpec.describe "as a visitor", type: :feature do
  describe "when I visit the /shelters page" do
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

    it "then I can visit the shelter index and show all shelter names" do
      visit "/shelters"

      expect(page).to have_content(shelter_1.name)
      expect(page).to have_content(shelter_2.name)
    end

    it "then I can visit an indexed shelter and see shelter data" do
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
      visit "/shelters/#{shelter_1.id}"

      click_link 'Update Shelter'

      expect(current_path).to eq "/shelters/#{shelter_1.id}/edit"

      fill_in 'Name', with: "Cat Care Society"
      fill_in 'Address', with: "5787 W 6th Ave"
      fill_in 'City', with: "Lakewood"
      fill_in 'State', with: "CO"
      fill_in 'Zip', with: "80214"

      click_button "Update Shelter"

      expect(current_path).to eq "/shelters/#{shelter_1.id}"
      expect(page).to have_content("Cat Care Society")
      expect(page).to have_content("5787 W 6th Ave")
      expect(page).to have_content("Lakewood")
      expect(page).to have_content("CO")
      expect(page).to have_content("80214")
    end
  end
end

# User Story 5, Shelter Update
#
# As a visitor
# When I visit a shelter show page
# Then I see a link to update the shelter "Update Shelter"
# When I click the link "Update Shelter"
# Then I am taken to '/shelters/:id/edit' where I  see a form to edit the shelter's data including:
# - name
# - address
# - city
# - state
# - zip
# When I fill out the form with updated information
# And I click the button to submit the form
# Then a `PATCH` request is sent to '/shelters/:id',
# the shelter's info is updated,
# and I am redirected to the Shelter's Show page where I see the shelter's updated info
