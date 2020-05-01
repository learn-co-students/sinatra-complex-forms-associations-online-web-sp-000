# Add seed data here. Seed your database with `rake db:seed`
sophie = Owner.create(name: "Sophie")
Pet.create(name: "Maddy", owner: sophie)
Pet.create(name: "Nona", owner: sophie)
johnson = Owner.create(name: 'Johnson')
Pet.create(name: 'Meadow', owner: johnson)
Pet.create(name: 'Nico', owner: johnson)
