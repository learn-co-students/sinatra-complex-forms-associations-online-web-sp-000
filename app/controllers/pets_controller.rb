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
    if !params["owner_name"].empty?
      @owner = Owner.create(name: params["owner_name"])
      @owner.pets << @pet
      @owner.save
    else
      @owner = Owner.find(params["owner_id"])
      @pet.owner = @owner
      @pet.save
    end
    
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end
  
  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    if !params["owner_name"].empty?
      @owner = Owner.create(name: params["owner_name"])
      @owner.pets << @pet
      @owner.save
    else
      @owner = Owner.find(params["owner_id"])
      @pet.owner = @owner
      @pet.save
    end
    
    if !params["pet_name"].empty?
      @pet.name = params["pet_name"]
      @pet.save
    end
    
    redirect to "pets/#{@pet.id}"
  end
end