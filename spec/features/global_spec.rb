require 'rails_helper'

RSpec.describe "As a visitor,
when I visit any page on the site", type: :feature do
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


    @pages = [
      "/shelters",
      "/shelters/new",
      "/shelters/#{@shelter_1.id}",
      "/shelters/#{@shelter_1.id}/edit",
      "/shelters/#{@shelter_1.id}/pets",
      "/shelters/#{@shelter_1.id}/pets/new",
      "/pets",
      "/pets/#{@pet_1.id}",
      "/pets/#{@pet_1.id}/edit"
    ]
  end

  it "when I click on the name of any shelter on the site
  that link brings me to that shelter's show page" do
    visit '/shelters'

    find_all(:link, @shelter_1.name).each do |link|
      link.click
      expect(current_path).to eq("/shelters/#{@shelter_1.id}")
      visit '/shelters'
    end

    visit '/pets'

    find_all(:link, @shelter_1.name).each do |link|
      link.click
      expect(current_path).to eq("/shelters/#{@shelter_1.id}")
      visit '/pets'
    end
  end

  it "when I click on the name of any pet on the site,
  I am taken to that pet's show page" do

    @pages.each do |href|
      find_all(:link, @pet_1.name).each do |link|
        visit href

        link.click
        expect(current_path).to eq("/pets/#{@pet_1.id}")
      end
    end
  end

  it "then I see a link at the top of the page that takes me to the Pet Index" do
    @pages.each do |href|
      visit href

      click_link "All Pets", href: "/pets"
      expect(current_path).to eq("/pets")
    end
  end

  it "then I see a link at the top of the page that takes me to the Shelters Index" do
    @pages.each do |href|
      visit href

      click_link "Shelters", href: "/shelters"
      expect(current_path).to eq("/shelters")
    end
  end
end


# User Story 19, Pet Index Link
#
# As a visitor
# When I visit any page on the site
# Then I see a link at the top of the page that takes me to the Pet Index
