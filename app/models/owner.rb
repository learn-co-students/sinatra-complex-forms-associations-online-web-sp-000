class Owner < ActiveRecord::Base
  has_many :pets
end
=begin
Active Record is smart enough to take that key of pet_ids,
 pointing to an array of numbers, find the pets that have those IDs,
  and associate them to the given owner, all because we set up
   our associations such that an owner has many pets.
=end