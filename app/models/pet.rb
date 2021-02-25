#4. create the model aka the key to the problem. 
# this creates the logic of the problem, reflect what the problem is and how it works, and thus help to solve a problem.
class Pet < ActiveRecord::Base
  belongs_to :owner
end