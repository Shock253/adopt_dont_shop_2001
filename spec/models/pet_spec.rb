require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'validations' do
    it do
      should validate_presence_of :image
      should validate_presence_of :name
      should validate_presence_of :description
      should validate_presence_of :age
      should validate_presence_of :sex
      should validate_presence_of :adoption_status
    end
  end

  describe 'relationships' do
    it {should belong_to :shelter}
  end
end
