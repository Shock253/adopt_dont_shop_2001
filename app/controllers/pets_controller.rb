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
end
