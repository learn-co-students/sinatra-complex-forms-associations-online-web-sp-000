class Owner < ActiveRecord::Base
  has_many :pets
end

#Note the active record associations
#Telling Active Record what the SQL queries are