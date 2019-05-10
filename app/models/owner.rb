class Owner < ActiveRecord::Base
  has_many :pets
  # attr_accessor :pet_ids
end