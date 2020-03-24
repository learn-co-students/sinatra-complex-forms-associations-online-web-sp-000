class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    
    erb :'/pets/index' 
  end
  # loads form to create a new pet
  get '/pets/new' do 
    @owners = Owner.all 
    erb :'/pets/new'
  end
  # creates a new pet and associates an existing owner
  # creates a new pet and a new owner
  post '/pets' do 
    # binding.pry
    @pet = Pet.create(params[:pet])
    # if owner created assign it to pet's owner
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end 
    @pet.save
    #binding.pry 
    redirect to "pets/#{@pet.id}"
  end
  # loads form to edit a pet and his owner
  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all 
    erb :'/pets/edit'
  end 

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
   
    erb :'/pets/show'
  end
  # edit's the pet's name
  # edit's the pet's owner with an existing owner
  # edit's the pet's owner with a new owner
  patch '/pets/:id' do 
    if !params[:pet].keys.include?("owner_id")
      params[:pet]["owner_id"] = []
    end

    @pet = Pet.find(params[:id])
   #binding.pry
    @pet.update(params["pet"])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.new(:name => params["owner"]["name"])
    end 
    @pet.save
    
    redirect to "pets/#{@pet.id}"
  end
end