# Add seed data here. Seed your database with `rake db:seed`
# 'seeding the database' refers to the practice of filling up your database with some dummy data
# as we develop our apps, it's essential that we have some data to work with
# when you run rake db:seed , the code in the seed file will be exectued, inserting sample data into your database
sophie = Owner.create(name: "Sophie")
Pet.create(name: "Maddy", owner: sophie)
Pet.create(name: "Nona", owner: sophie)