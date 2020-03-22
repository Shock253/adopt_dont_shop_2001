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

   def edit
     @pet = Pet.find(params[:id])
   end

   def update
     pet = Pet.find(params[:id])
     pet.update(pet_params)
     redirect_to "/pets/#{params[:id]}"
   end

   def destroy
     Pet.destroy(params[:id])
     redirect_to "/pets"
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
