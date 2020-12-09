class Pet < ActiveRecord::Base
  belongs_to :owner
end

#Note the active record associations
#Telling Active Record what the SQL queries are