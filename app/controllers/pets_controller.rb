class PetsController < ApplicationController
   def index
     @shelters = Shelter.all
   end
end
