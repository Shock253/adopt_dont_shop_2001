class PetsController < ApplicationController
   def index
     @shelters = Shelter.all
   end

   def shelter_index
     @shelter = Shelter.find(params[:shelter_id])
   end

   def show
     @pet = Pet.find(params[:id])
   end

   def new
     @shelter = Shelter.find(params[:shelter_id])
   end

   def create
     shelter = Shelter.find(params[:shelter_id])
     shelter.pets.create(pet_params)
     redirect_to "/shelters/#{params[:shelter_id]}/pets"
   end

   private

   def pet_params
     params.permit(:image,
                   :name,
                   :description,
                   :age,
                   :sex,
                   :adoption_status
                 )
   end
end
