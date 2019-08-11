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
    #binding.pry
    @pet = Pet.create(params[:pet])

    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
      @pet.save
    end

    redirect to "pets/#{@pet.id}"
  end
<<<<<<< HEAD

  get '/pets/:id/edit' do
=======
  
  get '/pets/:id/edit' do 
>>>>>>> a190141b0f8fc08b54202689c47d3b4643d30eee
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

<<<<<<< HEAD
  patch '/pets/:id' do
    @pet = Pet.find(params[:id])

    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
      @pet.save
    else
      if !params["pet"]["owner_id"].empty?
        @pet.owner = Owner.find(params["pet"]["owner_id"])
        @pet.save
      end
    end

    @pet.name = params["pet"]["name"]
    @pet.save

=======
  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(params["owner"]["name"])
      @pet.save
    end
    
    @pet.name = params["pet"]["name"]
    @pet.owner = Owner.find(id: params["pet"]["owner_id"])
    @pet.save
    
>>>>>>> a190141b0f8fc08b54202689c47d3b4643d30eee
    redirect to "pets/#{@pet.id}"
  end
end
