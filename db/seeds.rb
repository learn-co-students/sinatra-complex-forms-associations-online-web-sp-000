# Add seed data here. Seed your database with `rake db:seed`
#Creating and saving an instance of our Owner class and creating and saving two new instances of the Pet class.
sophie = Owner.create(name: "Sophie")
Pet.create(name: "Maddy", owner: sophie)
Pet.create(name: "Nona", owner: sophie)
