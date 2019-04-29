# Add seed data here. Seed your database with `rake db:seed`
maddy = Owner.create(name: "Maddy")
Pet.create(name: "Catsby", owner: maddy)
Pet.create(name: "Casey", owner: maddy)
