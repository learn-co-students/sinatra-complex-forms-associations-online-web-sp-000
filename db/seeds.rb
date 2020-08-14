# Add seed data here. Seed your database with `rake db:seed`
sophie = Owner.create(name: "Sophie")
Pet.create(name: "Maddy", owner: sophie)
Pet.create(name: "Nona", owner: sophie)
pet = Pet.create(name: "valentino")

# params = {"owner"=>{"name"=>"Adele", "pet_ids"=>["1", "2"]}}
# # p params
# params = {"owner"=>{"name"=>"Yarvin", "pet_ids"=>["9"]}}
# p "owner",owner = Owner.create(params["owner"])
# p "owner.pets",owner.pets
# p "pet",pet