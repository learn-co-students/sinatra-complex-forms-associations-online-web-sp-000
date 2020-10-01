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
    if !params["owner"]["name"].empty?
      new_owner = Owner.create(name: params["owner"]["name"])
      params["pet"]["owner_id"] = new_owner.id
    end
      @pet = Pet.create(name: params["pet"]["name"], owner_id: params["pet"]["owner_id"])
      @pet.owner = Owner.find(@pet.owner_id)
    redirect "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owner = @pet.owner
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  

  patch '/pets/:id' do 
    
    @pet = Pet.find(params[:id])
    if !params["owner"]["name"].empty?
      new_owner = Owner.create(name: params["owner"]["name"])
      params["pet"]["owner_id"] = new_owner.id
    end

    Pet.update(name: params["pet"]["name"], owner_id: params["pet"]["owner_id"])
      @pet.owner = Owner.find(params["pet"]["owner_id"])



    redirect to "pets/#{@pet.id}"
  end

  
end