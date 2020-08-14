class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
     @owners = Owner.all
     erb :'/pets/new'
  end

  post '/pets' do 

     @pet = Pet.create(name: params["pet_name"])
    params["owner_id"]
       if !params["owner"]["name"].empty?
         owner = Owner.create(name: params["owner"]["name"])
         @pet.owner = owner
         @pet.save

       elsif !params["owner_id"].empty?
         owner = Owner.find_by(id: params["owner_id"])
         @pet.owner = owner
         @pet.save
      end
      redirect to "pets/#{@pet.id}"
   end

    get '/pets/:id/edit'  do
     @owners = Owner.all
     @pet = Pet.find(params[:id])
      erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

 

  patch '/pets/:id' do 
      @pet = Pet.find_by(id: params[:id])
       @pet.name = params["pet_name"]
       @pet.save
      if !params["owner"]["name"].empty?
         @pet.owner = Owner.create(name: params["owner"]["name"])
         @pet.save
       elsif !params["pet"]["owner_id"].empty?
    
         owner  = Owner.find_by(id: params[:pet][:owner_id])
         @pet.owner = owner
        @pet.save    
      @pet
      end 
     redirect to "pets/#{@pet.id}"
  end
end