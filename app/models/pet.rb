class Pet < ApplicationRecord
  validates_presence_of :image,
                        :name,
                        :description,
                        :age,
                        :sex,
                        :adoption_status
  belongs_to :shelter
end
