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

    it "then I can delete a shelter from the database" do
      visit "/shelters/#{shelter_1.id}"

      click_link 'Delete Shelter'

      expect(current_path).to eq('/shelters')

      expect(page).to not_have_content("MaxFund Dog Shelter")
      expect(page).to not_have_content("1005 Galapago St")
      expect(page).to not_have_content("Denver")
      expect(page).to not_have_content("CO")
      expect(page).to not_have_content("80204")
    end
  end
end


# User Story 6, Shelter Delete
#
# As a visitor
# When I visit a shelter show page
# Then I see a link to delete the shelter
# When I click the link "Delete Shelter"
# Then a 'DELETE' request is sent to '/shelters/:id',
# the shelter is deleted,
# and I am redirected to the shelter index page where I no longer see this shelter
